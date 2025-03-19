#!/bin/bash
mkdir service-result
# Copy output files to local machine
docker cp 2868dc579adc54f8ad05359081853996de18949cfccce5f956434e1ed61c7d1c:/home/doc-bd-a1/res_dpre.csv ./service-result/
docker cp 2868dc579adc54f8ad05359081853996de18949cfccce5f956434e1ed61c7d1c:/home/doc-bd-a1/eda-in-1.txt ./service-result/
docker cp 2868dc579adc54f8ad05359081853996de18949cfccce5f956434e1ed61c7d1c:/home/doc-bd-a1/vis.png ./service-result/
docker cp 2868dc579adc54f8ad05359081853996de18949cfccce5f956434e1ed61c7d1c:/home/doc-bd-a1/eda-in-2.txt ./service-result/
docker cp 2868dc579adc54f8ad05359081853996de18949cfccce5f956434e1ed61c7d1c:/home/doc-bd-a1/eda-in-3.txt ./service-result/
docker cp 2868dc579adc54f8ad05359081853996de18949cfccce5f956434e1ed61c7d1c:/home/doc-bd-a1/k.txt ./service-result/

# Stop the container
docker stop 2868dc579adc54f8ad05359081853996de18949cfccce5f956434e1ed61c7d1c

