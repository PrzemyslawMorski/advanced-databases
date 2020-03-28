FROM python:3

RUN python --version

RUN python -m pip install psycopg2

ADD run_command.py /

CMD [ "python", "/run_command.py" ]
