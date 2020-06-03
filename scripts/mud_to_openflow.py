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

def handle_nw(incoming,src,dst,remote_abstraction):
	
	r_src = ''
	r_dst = ''

	if incoming:
		r_dst = map_address(dst)

		if remote_abstraction == 'internet':
			try:
				r_src = socket.gethostbyname(src)
			except:
				print(f"[ERROR] Error resolving {src}")
				r_src = None

		else:
			r_src = map_address(src)

	else:
		r_src = map_address(src)

		if remote_abstraction == 'internet':
			try:
				r_dst = socket.gethostbyname(dst)
			except Exception as e:
				print(f"[ERROR] Error resolving {dst}")
				r_dst = None
			
		else:
			r_dst = map_address(dst)

	return r_src,r_dst

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


def main():
	net_graph = read_net_graph()

	rules = []

	for index,edge in net_graph.iterrows():

		nw_src,nw_dst = handle_nw(edge['incoming'],edge['src'],edge['dst'],edge['remote_abstraction'])

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