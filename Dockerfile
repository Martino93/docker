#Use CentOS 7 as the container OS
FROM centos:7

#Copy our files to the container
COPY . ./app

#Install python and other programs required to run our app
RUN yum install -y python-pip python36u python36u-libs python36-devel python36u-pip uwsgi which gcc

#Change the working directory to /app
WORKDIR /app

#Changing the default python version from 2 to 3. We do this by first renaming the old python version and linking python filename to python3.6.
RUN mv /usr/bin/python /usr/bin/python_oldRUN cd /usr/bin && ln -s python3.6 python

#Install the required python packages listed in the requirements file
RUN python -m pip install -r requirements.txt

#Run uwsgi with the configuration in the .ini file
CMD ["uwsgi","--ini","app.ini"]

#Expose port 90 of the container to the outside
EXPOSE 90