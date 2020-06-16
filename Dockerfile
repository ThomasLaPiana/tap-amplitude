FROM python:3.7

# Install the tap dependencies
RUN pip install -U pip
COPY . /.
RUN pip install -e .

# Copy over the rest of the files
RUN python setup.py develop