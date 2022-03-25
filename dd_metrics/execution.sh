#!/bin/bash

#imposto le variabili necessarie
path= #a scelta
filename=list_metrics.txt #lista_metrica estratte con script extract_Mtype
tbin=/usr/bin/terraform
tvars=terraform.tfvars
tstate=terraform.tfstate
log= #a scelta path log

#i log di seguito serviranno per le condition if
t_fmt_log=logs/t_fmt.log
t_init_log=logs/t_init.log
t_validate_log=t_validate.log
t_plan_log=t_plan.log
t_apply_log=t_apply.log

#file errore e final_result
error_log=error.log
finalfile=final_result.txt

#nel caso fosse presente rimuovo il file tfstate
rm $tstate

for metrics in $(cat $path/$filename);do
    cd $path
    echo $metrics
    tmp_1=$(echo $metrics | awk -F , '{print $1}')
    echo "datadog_metrics_name = \"$tmp_1\"" > $tvars 
    tmp_2=$(echo $metrics | awk -F , '{print $2}')
    echo "datadog_metrics_type = \"$tmp_2\"" >> $tvars 

    #inizio terraform fmt (normalizzo i file terraform)
    $tbin fmt &> $t_fmt_log
        #terraform init (inizializzo la cartella e installa i plugin necessari)
        $tbin init &> $t_init_log
        result_init=$(cat $t_init_log | grep "Terraform has been successfully initialized!")
        if [[ $result_init == *"successfully"* ]]
        then
            #terraform validate (valido i file di configuraizone)
            $tbin validate &> $t_validate_log
            result_validate=$(cat $t_validate_log | grep "Success")
            if [[ $result_validate == *"Success"* ]]
            then
                #terraform plan (eseguo il plan per verificare cosa viene modificato)
                $tbin plan &> $t_plan_log
                result_plan=$(cat $t_plan_log | grep "Plan")
                if [[ $result_plan == *"1 to add"* ]]
                then
                    #terraform apply (applico le modifiche impostate nell'apply)
                    $tbin apply -auto-approve &> $t_apply_log
                    result_apply=$(cat $t_apply_log | grep "complete")
                    result_apply_kerror=$(cat $t_apply_log | grep "409 Conflict")
                    if [[ $result_apply == *"Apply complete"* ]]
                    then
                        echo "[`date +"%Y-%m-%d %H:%M:%S"`] modificata metrica $metrics" >> $finalfile
                    elif [[ $result_apply_kerror == *"conflicts with existing tag"* ]]
                    then
                        echo "[`date +"%Y-%m-%d %H:%M:%S"`] metrica già modificata - vado avanti $metrics" >> $finalfile
                    else
                        echo "[`date +"%Y-%m-%d %H:%M:%S"`] errore in fase di apply - mi fermo $metrics" > $error_log
                        exit 1
                    fi
                else
                    echo "[`date +"%Y-%m-%d %H:%M:%S"`] errore in fase di plan - mi fermo $metrics" > $error_log
                    exit 1
                fi
            else
                echo "[`date +"%Y-%m-%d %H:%M:%S"`] errore in fase di validate - mi fermo $metrics" > $error_log
                exit 1
            fi
        else
            echo "[`date +"%Y-%m-%d %H:%M:%S"`] errore in fase di init - mi fermo $metrics" > $error_log
            exit 1  
        fi
rm $tstate
done