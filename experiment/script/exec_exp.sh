#!/bin/bash

N_TARGETS=''
BOT_ID=''
PROTECTION=''

function print_help {
	echo "Uso correto: $0 <N_TARGETS> <BOT_ID> <PROTECTION>"
	echo "	N_TARGETS	Inteiro com número de containers vulneráveis a ser utilizada no experimento"
	echo "	BOT_ID		Identificação do bot semente. Pode ser um inteiro ou 'all'"
	echo "	PROTECTION	Medida de proteção a ser aplicada. Pode ser 'open', 'mud' ou 'mtd'"
	exit 0
}

# VALIDAÇÃO
if ! [ $# == 3 ]; then
	print_help
fi

if ! [[ $1 =~ ^[0-9]+$ ]]; then
	echo "ERRO: N_TARGETS deve ser um inteiro"
	print_help
else
	N_TARGETS=$1
fi

if ! [[ $2 =~ ^([0-9]+|all)$ ]]; then
	echo "ERRO: BOT_ID deve ser um inteiro ou 'all'"
	print_help
else
	BOT_ID=$2
fi

if ! [[ $3 =~ ^(open|mud|mtd)$ ]]; then
	echo "ERRO: PROTECTION deve ser 'open', 'mud' ou 'mtd'"
	print_help
elif [[ $3 == 'open' ]]; then
	PROTECTION='all'
else
	PROTECTION=$3
fi
# /VALIDAÇÃO

# EXECUÇÃO
bash start_targets.sh $N_TARGETS
sleep 10s

if [[ $BOT_ID =~ ^[0-9]+$ ]]; then
	bash load_bot.sh $BOT_ID
	bash regras.sh $PROTECTION
	bash run_bot.sh $BOT_ID
else
	bash load_all_bots $N_TARGETS
	bash regras.sh $PROTECTION
	bash run_all_bots.sh $N_TARGETS
fi

bash attacks.sh
bash stop_targets.sh $N_TARGETS
bash get_counters.sh $BOT_ID $PROTECTION
# /EXECUÇÃO