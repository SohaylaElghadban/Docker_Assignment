CMD COMMANDS USED:
ON LOCAL MACHINE => mkdir bd-a1
                    -----------------------------------------------
                    cd bd-a1
                    ------------------------------------------------
                     wget -O iris.csv "https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv" => Extracting our csv file used from internet
                     -----------------------------------------------
                     notepad Dockerfile => to write following commands 
                                                  < # Use Ubuntu as the base image
                                                      FROM ubuntu:latest
                                                      
                                                      # Install necessary packages
                                                      RUN apt-get update && \
                                                          apt-get install -y python3 python3-pip && \
                                                          pip3 install --break-system-packages pandas numpy seaborn matplotlib scikit-learn scipy
                                                      
                                                      # Create the working directory
                                                      RUN mkdir -p /home/doc-bd-a1
                                                      
                                                      # Set the working directory
                                                      WORKDIR /home/doc-bd-a1
                                                      
                                                      # Copy the dataset into the container
                                                      COPY iris.csv /home/doc-bd-a1/
                                                      
                                                      # Open bash shell on container startup
                                                      CMD ["/bin/bash"]>
                      
                        docker build -t bd-a1-image . => to build a Docker image from a Dockerfile mentioned up 
                        -----------------------------------------------
                        docker run -it --name bd-a1-container bd-a1-image => create and start a Docker container from an existing Docker image.
                        -----------------------------------------------
                        After this command, we are dealing with root with the following commands:
                        touch load.py dpre.py eda.py vis.py model.py => to create the files needed
                        -----------------------------------------------
                        echo 'import sys
                        import pandas as pd
                        
                        if len(sys.argv) != 2:
                            print("Usage: python3 load.py <dataset-path>")
                            sys.exit(1)
                        
                        dataset_path = sys.argv[1]
                        df = pd.read_csv(dataset_path)
                        
                        # Pass the dataset to the next script
                        df.to_csv("/home/doc-bd-a1/processed_data.csv", index=False)
                        print("Dataset loaded and saved as processed_data.csv")
                        
                        # Call the next script
                        import subprocess
                        subprocess.run(["python3", "dpre.py", "/home/doc-bd-a1/processed_data.csv"])' > load.py 
                        -----------------------------------------------
                        echo 'import sys
                        import pandas as pd
                        
                        if len(sys.argv) != 2:
                            print("Usage: python3 dpre.py <dataset-path>")
                            sys.exit(1)
                        
                        dataset_path = sys.argv[1]
                        df = pd.read_csv(dataset_path)
                        
                        # Perform data preprocessing steps
                        # Example: Drop missing values
                        df = df.dropna()
                        
                        # Save the processed data
                        df.to_csv("/home/doc-bd-a1/res_dpre.csv", index=False)
                        print("Data preprocessing completed. Saved as res_dpre.csv")
                        
                        # Call the next script
                        import subprocess
                        subprocess.run(["python3", "eda.py", "/home/doc-bd-a1/res_dpre.csv"])' > dpre.py
                        -----------------------------------------------
                        echo 'import sys
                        import pandas as pd
                        
                        if len(sys.argv) != 2:
                            print("Usage: python3 eda.py <dataset-path>")
                            sys.exit(1)
                        
                        dataset_path = sys.argv[1]
                        df = pd.read_csv(dataset_path)
                        
                        # Perform exploratory data analysis
                        insight1 = f"Number of rows: {len(df)}\n"
                        insight2 = f"Number of columns: {len(df.columns)}\n"
                        insight3 = f"Column names: {', '.join(df.columns)}\n"
                        
                        # Save insights as text files
                        with open("/home/doc-bd-a1/eda-in-1.txt", "w") as f:
                            f.write(insight1)
                        with open("/home/doc-bd-a1/eda-in-2.txt", "w") as f:
                            f.write(insight2)
                        with open("/home/doc-bd-a1/eda-in-3.txt", "w") as f:
                            f.write(insight3)
                        print("EDA completed. Insights saved as eda-in-*.txt")
                        
                        # Call the next script
                        import subprocess
                        subprocess.run(["python3", "vis.py", "/home/doc-bd-a1/res_dpre.csv"])' > eda.py
                        -----------------------------------------------
                        echo 'import sys
                        import pandas as pd
                        import matplotlib.pyplot as plt
                        
                        if len(sys.argv) != 2:
                            print("Usage: python3 vis.py <dataset-path>")
                            sys.exit(1)
                        
                        dataset_path = sys.argv[1]
                        df = pd.read_csv(dataset_path)
                        
                        # Create a visualization
                        df.hist()
                        plt.savefig("/home/doc-bd-a1/vis.png")
                        print("Visualization saved as vis.png")
                        
                        # Call the next script
                        import subprocess
                        subprocess.run(["python3", "model.py", "/home/doc-bd-a1/res_dpre.csv"])' > vis.py
                        -----------------------------------------------
                        echo 'import sys
                        import pandas as pd
                        from sklearn.cluster import KMeans
                        
                        if len(sys.argv) != 2:
                            print("Usage: python3 model.py <dataset-path>")
                            sys.exit(1)
                        
                        dataset_path = sys.argv[1]
                        df = pd.read_csv(dataset_path)
                        
                        # Perform K-means clustering
                        kmeans = KMeans(n_clusters=3)
                        df['cluster'] = kmeans.fit_predict(df.select_dtypes(include=['float64', 'int64']))
                        
                        # Save the number of records in each cluster
                        cluster_counts = df['cluster'].value_counts().to_string()
                        with open("/home/doc-bd-a1/k.txt", "w") as f:
                            f.write(cluster_counts)
                        print("K-means clustering completed. Results saved as k.txt")' > model.py
                        -----------------------------------------------
                        python3 load.py /home/doc-bd-a1/iris.csv => uns a Python script named load.py and passes the file path /home/doc-bd-a1/iris.csv as an argument to the script.
                        -----------------------------------------------
                        exit
                        -----------------------------------------------
GIT BASH COMMANDS  =>   cd /c/Users/sohay/OneDrive/Documents/Desktop/bd-a1
                        -----------------------------------------------
                        nano final.sh
                        -----------------------------------------------
                        write the following commands:
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
                        -----------------------------------------------
                        chmod +x final.sh => o make a file executable
                        -----------------------------------------------
                        $ bash final.sh => copying file to local machine
                        -----------------------------------------------
                        bonus:
BONUS COMMANDS =>      docker login
                      -----------------------------------------------
                       docker tag bd-a1-image sohaylaelghadban/bd-a1-image
                       ----------------------------------------------
                       docker push sohaylaelghadban/bd-a1-image
                       -----------------------------------------------
                        git hub part:
                        git init
                        git add .
                        git commit -m"FILES ADDED"
                        git branch -M main
                        git remote add origin https://github.com/SohaylaElghadban/Docker_Assignment
                        git push -u origin main --force



                        
                        
