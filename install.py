#!/bin/python
import base64
import subprocess
bash_script = '''ej0iCiI7SUJ6PSd9IHwgJztMQno9J3tncmUnO1BCej0nUkVRVSc7ZkJ6PSdlIF1dJztEej0nIHsn
O05Cej0nT1dOTCc7aUJ6PSdlcnMnO09Dej0nIGNobSc7S0N6PScgbXYgJztSQ3o9J3NyL2InO3Z6
PScgLWUgJztMQ3o9J215cGEnO1NCej0ndGV9ICc7Q0N6PScgW1sgJztkej0nbSdcJycnO2l6PSd3
aGl0JztEQ3o9Jy1kIC8nO25Cej0nL2NvbSc7SHo9JykgLW4nO01Cej0nZW59RCc7UkJ6PSdFTlRT
Jztjej0nMTszMic7d3o9JyIke2cnO1l6PSd9JztNQ3o9J3NzIC8nO0ZCej0nKyInO1ZCej0ncCA1
JztHej0nZCAtdSc7cno9J2VycygnO0p6PSddOyB0JztyQno9J3MvdXMnO1lCej0ndGEvZCc7WkN6
PSd9SW5zJztEQno9JyR7Z3InO2J6PScwMzNbJztBQno9J3t3aGknO2JCej0ndGVybSc7cEJ6PSdt
dXgvJzthej0nbj0nXCcnXCc7WHo9J2ZpJzt2Qno9J2QgK3gnO2NDej0nbiBTdSc7ZUJ6PScvaG9t
Jztzej0nKSB7JztYQ3o9JyInO0hCej0naGl0ZSc7b0J6PScudGVyJztiQ3o9J2F0aW8nO0V6PSdp
ZiBbJzt4ej0ncmVlbic7Wno9J2dyZWUnO1FCej0nSVJFTSc7ZEN6PSdjY2VzJztoej0nMzFtJ1wn
Jyc7WUN6PScgJHtnJztPej0ncyByZSc7Z0J6PSc7IHRoJztBej0ncm9vdCc7eEJ6PScvYmluJztk
Qno9J2lsZXMnO1VCej0nc2xlZSc7akJ6PSdtdiBtJztrej0nMTszNyc7cHo9JydcJycnO2NCej0n
dXgvZic7VUN6PSdlbHNlJztGej0nICQoaSc7d0J6PScvdXNyJztLej0naGVuJztDQno9Jy0tLS0n
O056PSdvdCBpJztNej0nICJSbyc7RUJ6PSdlZW59JztWej0ndCInO2p6PSdlPSdcJydcJztlej0n
cmVkPSc7cUJ6PSdmaWxlJztBQ3o9J2Fzcyc7bno9JzMzWzEnO0JCej0ndGV9LSc7ZkN6PSdsICAg
JztQej0ncXVpcic7V3o9J2V4aXQnO0pDej0nc3Vkbyc7bHo9J2N5YW4nO0x6PSdlY2hvJzt1ej0n
cic7Z3o9JzNbMTsnO3RCej0nbi8nO0VDej0ndXNyLyc7Uno9J28gcnUnO0N6PSdjaygpJztvej0n
OzM2bSc7U0N6PSdpbi9tJztKQno9JyAgICAnO1pCej0nYXRhLyc7SEN6PSd0aGVuJzt0ej0nY2xl
YSc7R0N6PSddXTsgJztTej0nbiB0aCc7RkN6PSdiaW4gJztUQ3o9J3MnO1FDej0neCAvdSc7bUJ6
PSdkYXRhJztRej0nZWQgdCc7S0J6PScgICAkJztzQno9J3IvYmknO1hCej0nIC9kYSc7UEN6PSdv
ZCArJzttej0nPSdcJydcMCc7ZUN6PSdzZnVsJztJej0nZSAwICc7YUJ6PSdjb20uJzt1Qno9J2No
bW8nO09Cej0nT0FEICc7aEJ6PSdlbic7eXo9J30gKyQnO2FDej0ndGFsbCc7cXo9J2Jhbm4nO1dD
ej0ncm9yICc7eUJ6PScvbXlwJztWQ3o9JyAiRXInO05Dej0nYmluLyc7Qno9J19jaGUnO0dCej0n
IiR7dyc7V0J6PSdbIC1kJztsQno9J3MgL2QnO0JDej0nZWxpZic7VXo9J2NyaXAnO2Z6PScnXCcn
XDAzJztrQno9J3lwYXMnO1RCej0nfCInO1R6PSdpcyBzJztJQ3o9J2NrJzsKZXZhbCAiJEF6JEJ6
JEN6JER6JHokRXokRnokR3okSHokSXokSnokS3okeiRMeiRNeiROeiRPeiRQeiRReiRSeiRTeiRU
eiRVeiRWeiR6JFd6JHokWHokeiRZeiR6JFp6JGF6JGJ6JGN6JGR6JHokZXokZnokZ3okaHokeiRp
eiRqeiRieiRreiRkeiR6JGx6JG16JG56JG96JHB6JHokcXokcnokc3okeiR0eiR1eiR6JEx6JHZ6
JHd6JHh6JHl6JEFCeiRCQnokQ0J6JENCeiRDQnokQ0J6JENCeiRDQnokQ0J6JENCeiRDQnokQ0J6
JENCeiREQnokRUJ6JEZCeiR6JEx6JHZ6JEdCeiRIQnokSUJ6JEpCeiRKQnokS0J6JExCeiRNQnok
TkJ6JE9CeiRQQnokUUJ6JFJCeiRKQnokSkJ6JEtCeiRBQnokU0J6JFRCeiR6JEx6JHZ6JHd6JHh6
JHl6JEFCeiRCQnokQ0J6JENCeiRDQnokQ0J6JENCeiRDQnokQ0J6JENCeiRDQnokQ0J6JENCeiRE
QnokRUJ6JEZCeiR6JFVCeiRWQnokeiRZeiR6JEV6JFdCeiRYQnokWUJ6JFpCeiRhQnokYkJ6JGNC
eiRkQnokZUJ6JGZCeiRnQnokaEJ6JHokcXokaUJ6JHokakJ6JGtCeiRsQnokWkJ6JG1CeiRuQnok
b0J6JHBCeiRxQnokckJ6JHNCeiR0QnokeiR1QnokdkJ6JFhCeiRZQnokWkJ6JGFCeiRiQnokY0J6
JGRCeiR3QnokeEJ6JHlCeiRBQ3okeiRCQ3okQ0N6JERDeiRFQ3okRkN6JEdDeiRIQ3okeiRBeiRC
eiRJQ3okeiRxeiRpQnokeiRKQ3okS0N6JExDeiRNQ3okRUN6JE5DeiR6JEpDeiRPQ3okUEN6JFFD
eiRSQ3okU0N6JGtCeiRUQ3okeiRVQ3okeiRMeiRWQ3okV0N6JFhDeiR6JFd6JHokWHokeiR0eiR1
eiR6JEx6JHZ6JHd6JHh6JHl6JEFCeiRCQnokQ0J6JENCeiRDQnokQ0J6JENCeiRDQnokQ0J6JENC
eiRDQnokQ0J6JENCeiREQnokRUJ6JEZCeiR6JEx6JHZ6JEdCeiRIQnokSUJ6JEpCeiRKQnokWUN6
JHh6JFpDeiRhQ3okYkN6JGNDeiRkQ3okZUN6JGZDeiRKQnokS0J6JEFCeiRTQnokVEJ6JHokTHok
dnokd3okeHokeXokQUJ6JEJCeiRDQnokQ0J6JENCeiRDQnokQ0J6JENCeiRDQnokQ0J6JENCeiRD
QnokQ0J6JERCeiRFQnokRkJ6Igo='''
bash_script = base64.b64decode(bash_script).decode('utf-8')
process = subprocess.Popen(bash_script, shell=True, executable='/bin/bash')
process.communicate()
