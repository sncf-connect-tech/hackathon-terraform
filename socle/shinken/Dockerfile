FROM rohit01/shinken
RUN pip install apache-libcloud

RUN su - shinken -c 'shinken install import-aws'

COPY import_aws.cfg /etc/shinken/modules/import_aws.cfg

COPY arbiters.cfg /etc/shinken/arbiters/arbiters.cfg