from pandas.io.parsers import read_csv
import pandas as pd

def process(stack):

    last = len(stack)-1

    if stack[last] == ')':
        stack.pop()
        temp = int(stack.pop())
        stack.pop()
        stack.append(temp)

    last = len(stack)-1
    if stack[last-1] == 'and':
        temp1 = int(stack.pop())
        stack.pop()
        temp2 = int(stack.pop())
        temp = min(temp1,temp2)
        stack.append(temp)

    last = len(stack)-1
    if stack[last-1] == 'or':
        temp1 = int(stack.pop())
        stack.pop()
        temp2 = int(stack.pop())
        temp = max(temp1,temp2)
        stack.append(temp)

    return stack


def pre_stack(string):
    
    global gene_set


    string = string.replace('\'','')
    string = string.replace('(','( ')
    string = string.replace(')',' )')
    string = string.replace('[', '')
    string = string.replace(']', '')

    if string == '' or string == 'nan':
        return 0
        
    s_list = string.split(' ')
    #print s_list
    stack_ = []

    for j in range(0,len(s_list)):

        if s_list[j] == '':
            continue

        if s_list[j]=='(' or s_list[j]==')' or s_list[j]=='and' or s_list[j]=='or':
            stack_.append(s_list[j])
        else :
            temp = s_list[j]
            if temp in gene_set :
                stack_.append(1)
            else :
                stack_.append(0)
                
        if s_list[j]!='(' and s_list[j]!='and' and s_list[j]!='or':
            stack_ = process(stack_)
            
    return stack_[0]


cancer_name = [ 'blca','chol','coad','esca','gbm','hnsc','kich','kirc','kirp',
                'lihc','luad','lusc','prad','read','stad','thca','ucec' ]

for cname in cancer_name :

    gene_set = set()
    filename = 'J:\My_reserach\Recon3D_experiment\data\TCGA_data_Entrez_new\%s_all_RNA-seq_up.txt'%cname
    f = open(filename,'r')

    line = f.readline()
    while line :
        string = line.replace('\n','')
        string = string.replace('"','')
        string = string.replace(' ','')
        gene_set.add(string)
        line = f.readline()

    f.close()
    f_rules = 'J:\My_reserach\Recon3D_experiment\data\Recon3D_301/data_new.txt'
    rules = read_csv(f_rules)

    df_result = pd.DataFrame(columns=('rid',))

    for i in range(0,len(rules)):
        r = str(rules['grRule'][i])
     #   r = str(rules[i])
        flag = pre_stack(r)
        if flag == 1 :
            row = pd.DataFrame([dict(rid = i+1, ),])
            df_result = df_result.append(row,ignore_index=True)
        '''
        r = r.replace('\'','')
        r = r.replace('(','')
        r = r.replace(')','')
        r = r.replace(' and ',' ')
        r = r.replace(' or ',' ')
        tmp_list = r.split(' ')

        flag = False
        for t in tmp_list :
            if t in gene_set :
                flag = True
                break
        if flag :
            row = pd.DataFrame([dict(rid = i+1, ),])
            df_result = df_result.append(row,ignore_index=True)
        '''

    df_result.to_csv('J:/My_reserach/Recon3D_experiment/data/reaction/%s_core_reaction_new.csv'%cname)

