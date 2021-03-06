#!/bin/bash
cd /home/ubuntu
sudo apt-update 
sudo apt install python3-pip -y
sudo python3 -m pip install ansible
tee -a playbook.yml > /dev/null << EOT
- hosts: localhost
  tasks:
  - name: Instalando o python3, virtualenv
    apt: 
      pkg:
      - python3
      - virtualenv
      update_cache: yes
    become: yes
  - name : Clonando repositorio
    ansible.builtin.git:
      repo: https://github.com/alura-cursos/clientes-leo-api.git
      dest: /home/ubuntu/tcc
      version: master 
      force: yes
  - name: Instalando dependencias com pip ( Django e DjangoRest)
    pip:
      virtualenv: /home/ubuntu/tcc/venv
      requirements: /home/ubuntu/tcc/requirements.txt
  - name: verificando se o projeto ja foi iniciado
    stat:
      path: /home/ubuntu/tcc/setup/settings.py
    register: projeto
  - name: Iniciando o projeto
    shell: '. /home/ubuntu/tcc/venv/bin/activate; django-admin startproject setup /home/ubuntu/tcc/'
    when: not projeto.stat.exists
  - name: Ajustando o host do settings.
    lineinfile:
      path: /home/ubuntu/tcc/setup/settings.py
      regexp: 'ALLOWED_HOSTS'
      line: 'ALLOWED_HOSTS = ["*"]'
      backrefs: yes
  - name: Configurando o banco de dados.
    shell: '. /home/ubuntu/tcc/venv/bin/activate; python /home/ubuntu/tcc/manage.py migrate'
  - name: Carregando os dados iniciais do banco.
    shell: '. /home/ubuntu/tcc/venv/bin/activate; python /home/ubuntu/tcc/manage.py loaddata clientes.json'
  - name: Iniciando o servidor.
    shell: '. /home/ubuntu/tcc/venv/bin/activate; nohup python /home/ubuntu/tcc/manage.py runserver 0.0.0.0:8000 &'
EOT

ansible-playbook playbook.yml