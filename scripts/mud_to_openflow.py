import socket
import pandas as pd

def read_net_graph():
	aux = pd.read_json("/tmp/mud_graph.json")
	return aux.drop_duplicates()

def read_nodes():
	aux = pd.read_json("/tmp/mud_nodes.json")
	return aux.drop_duplicates()

def map_address(name):
	nodes = read_nodes()
	try:
		return nodes[nodes.name==name].ip.item()
	except:
		print(f"[ERROR] Error locally resolving {name}")
		return None

def handle_tp(port):
	try:
		return int(port)
	except:
		return None

def default_rules(dhcp,dns):
	def_rules = []
	def_rules.append("priority=1,arp,action=normal")
	def_rules.append("priority=1,udp,nw_dst=255.255.255.255,tp_dst=67,action=normal")
	def_rules.append(f"priority=1,udp,nw_src={dhcp},tp_src=67,action=normal")
	def_rules.append(f"priority=1,udp,nw_dst={dns},tp_dst=53,action=normal")
	def_rules.append(f"priority=1,udp,nw_src={dns},tp_src=53,action=normal")
	def_rules.append("priority=0,action=drop")

	return "\n".join(def_rules)

def mount_rule(nw_src,nw_dst,transport,tp_src,tp_dst):
	rule = f"priority=100,{transport}"

	if nw_src is not None:
		rule += f",nw_src={nw_src}"

	if nw_dst is not None:
		rule += f",nw_dst={nw_dst}"

	if tp_src is not None:
		rule += f",tp_src={tp_src}"

	if tp_dst is not None:
		rule += f",tp_dst={tp_dst}"

	rule += ",action=normal\n"

	return rule

def resolv_domains(graph):
	mask_in = (graph['remote_abstraction'] == 'internet') & (graph['incoming'] == True)
	mask_out = (graph['remote_abstraction'] == 'internet') & (graph['incoming'] == False)

	dom_in = graph[mask_in]['src'].drop_duplicates()
	dom_out = graph[mask_out]['dst'].drop_duplicates()

	domains = pd.Series(dtype=str)

	domains = domains.append(dom_in, ignore_index=True)
	domains = domains.append(dom_out, ignore_index=True)
	domains = domains.drop_duplicates()
	
	resolved = []

	for dom in domains:

		mask_src = graph['src'] == dom
		mask_dst = graph['dst'] == dom

		try:
			addr = socket.gethostbyname(dom)
			
			resolved.append((dom, addr))

			graph.loc[mask_src,'src'] = addr
			graph.loc[mask_dst,'dst'] = addr
		except:
			graph.drop(graph[mask_dst | mask_src].index, inplace=True)
			print(f"[ERROR] Error resolving {dom}")

	aux = pd.DataFrame(resolved, columns=['domain', 'address'])
	with open('/tmp/resolved_names.json', 'w') as file:
		file.write(aux.to_json())

	return graph

def local_map(graph):
	mask_in = (graph['remote_abstraction'] != 'internet') & (graph['incoming'] == True)
	mask_out = (graph['remote_abstraction'] != 'internet') & (graph['incoming'] == False)

	dom_in = graph[mask_in]['src'].drop_duplicates()
	dom_out = graph[mask_out]['dst'].drop_duplicates()

	names = pd.Series(dtype=str)

	names = names.append(dom_in, ignore_index=True)
	names = names.append(dom_out, ignore_index=True)
	names = names.drop_duplicates()

	for name in names:

		mask_src = graph['src'] == name
		mask_dst = graph['dst'] == name

		try:
			addr = map_address(name)

			graph.loc[mask_src,'src'] = addr
			graph.loc[mask_dst,'dst'] = addr
		except:
			print(f"[ERROR] Error locally resolving {name}")

	return graph



def main():
	net_graph = read_net_graph()

	net_graph = resolv_domains(net_graph)
	net_graph = local_map(net_graph)

	rules = []

	for index,edge in net_graph.iterrows():

		nw_src,nw_dst = (edge['src'],edge['dst'])

		if((nw_dst is not None) and (nw_src is not None)):

			tp_src = handle_tp(edge['t_src'])
			tp_dst = handle_tp(edge['t_dst'])

			if edge['transport'].lower() == 'any':
				rules.append(mount_rule(nw_src,nw_dst,'tcp',tp_src,tp_dst))
				rules.append(mount_rule(nw_src,nw_dst,'udp',tp_src,tp_dst))
			elif (edge['transport'].lower() == 'tcp' or edge['transport'].lower() == 'udp'):
				rules.append(mount_rule(nw_src,nw_dst,edge['transport'].lower(),tp_src,tp_dst))

	rules = list(dict.fromkeys(rules))

	rules.append(default_rules("192.168.5.1","192.168.5.1"))

	with open("/tmp/mud_ovs_rules.txt",'w') as file:
		file.write(''.join(rules))


if __name__ == '__main__':
	main()
