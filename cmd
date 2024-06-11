start the slurm 
# systemctl restart slurmctld
# systemctl restart slurmd
# systemctl restart slurmdbd




sacct gives runig jobs details 
sreport gives info about compleated jobs



if any node gives * 
then do 
    # scontrol reconfigure



create user   
    # groupadd -g 20000 rma
    # useradd -u 20001 -g 20000 -m -d /nfs/rma-lab -s /bin/bash rma-lab




create account in slurm 
    # sacctmgr add account rmalab-acc

asign user to account
    # sacctmgr create user name=rma-lab DefaultAccount=rmalab-acc




QOS
    show the QOS
        #  sacctmgr show qos
        or 
        #  sacctmgr show qos format=name,priority


    create a new QOS
        # sacctmgr add qos zebra
                           `````

        #  sacctmgr show qos format=name,priority

    set priority for perticular QOS
        # sacctmgr modify qos zebra set priority=10
                              `````     ```````````
        
        #  sacctmgr show qos format=name,priority
        
    
    set the cpu limit for QOS
        # sacctmgr modify qos zebra set GrpTRES=CPU=10
                              `````     ``````````````

        #  sacctmgr show qos format=name,priority
        

    add user to the QOS
        # sacctmgr modify user crock set qos=zebra





    to add or apply acl rules 
        # vim /opt/slurm-21.08.8/etc/slurm.conf

        add or uncomment 
            AccountingStorageEnforce=associations,limits,qos

    limit for user to not submit job any how 

        # sacctmgr modify user hpcsa set maxsubmitjobs=0
                                         maxjobs=2

    limit or deny all user or associtaion account 
        # vim /opt/slurm-21.08.8/etc/slurm.conf
        
        PartitionName=testp Nodes=ALL Default=YES MaxTime=7-00:00:00 DefaultTime=00:02:00 State=UP DenyAccounts=physics-acc
                                                                                                   ````````````             
 
    allow or deny perticular groups
        
        PartitionName=testp Nodes=ALL Default=YES MaxTime=7-00:00:00 DefaultTime=00:02:00 State=UP DenyAccounts=physics-acc AllowGroups=rma-lab DenyGroups=hpcsa
                                                                                                                            ```````````         ``````````                    











---------------------------------------------------------
reservation 

$ scontrol create reservation starttime=2009-02-06T16:00:00 duration=120 user=root flags=maint,ignore_jobs nodes=ALL

$ scontrol create reservation starttime=2009-04-06T16:00:00 duration=120 user=root flags=license_only licenses=lustre:1000

$ scontrol create reservation user=root starttime=now duration=infinite flags=maint nodes=sun000

$ scontrol create reservation user=alan,brenda starttime=noon duration=60 flags=daily nodecnt=10

$ scontrol create reservation user=alan,brenda starttime=noon duration=60 flags=any_nodes burstbuffer=100GB

$ scontrol create reservation StartTime=now Duration=60 NodeCnt=1 CoreCnt=2 User=alan

$ scontrol create reservation account=foo user=-alan partition=pdebug starttime=noon duration=60 nodecnt=2k,2k

$ scontrol create reservationname=test start=now duration=1 user=user1 partition=gpu tres=cpu=24,node=4

$ sbatch --reservation=alan_6 -N4 my.script









reveration for user 
    # scontrol create reservation 
                            starttime=now    or   starttime=now+10minutes   or      starttime=2009-02-06T16:00:00

                            duration=10 
                            
                            user=hpcsa 
                            
                            flags=maint,ignore_jobs  or  magnetic
                             
                            nodes=ALL 
                            
                            
                            ReservationName=Root_4 or system define


exclued user 
    user=-hpcsa 

delete reservation   
    # scontrol delete ReservationName=Root_40










assignment

# create a reservation is created for account chemistry-acc but user hpcsa2 is prevented from using the reservation even when using the account chemistry-acc 

# reservation purging after last job 


    > scontrol create reservation starttime=now duration=120 user=root flags=maint,ignore_jobs,purge_comp nodes=ALL







install slurm bank

    slurm-bank-slurm-bank-1.2.1

        # chmod -R 755 /opt/slurm-bank-slurm-bank-1.2.1/
        
        # make 

        # make install DESTDIR=/opt/slurm-bank-slurm-bank-1.2.1


        # vim /etc/bash.bashrc
        >  export PATH=/opt/slurm-bank-slurm-bank-1.2.1/usr/bin:$PATH


        # source /etc/bash.bashrc




        # vim /opt/slurm-21.08.8/etc/slurm.conf

            > AccountingStorageEnforce=limits
            > PriorityType=priority/multifactor
            > PriorityDecayHalfLife=0
            > PriorityUsageResetPeriod=NONE





















