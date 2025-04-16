#run the container 
docker compose up -d
# run the image with interactive mode
docker exec -it hdfs_tp_1_namenode_1 bas

cat > /tmp/hdfs_tp.sh << 'EOF'
# !/bin/bash

# Étape 1
echo "Création de l'arborescence..."
hdfs dfs -mkdir /BDDC
hdfs dfs -mkdir /BDDC/JAVA
hdfs dfs -mkdir /BDDC/CPP
hdfs dfs -mkdir /BDDC/JAVA/Cours
hdfs dfs -mkdir /BDDC/JAVA/TPs
hdfs dfs -mkdir /BDDC/CPP/Cours
hdfs dfs -mkdir /BDDC/CPP/TPs

# Étape 2
echo "Création des fichiers avec contenu..."
echo "Contenu du cours CPP 1" | hdfs dfs -put - /BDDC/CPP/Cours/CoursCPP1
echo "Contenu du cours CPP 2" | hdfs dfs -put - /BDDC/CPP/Cours/CoursCPP2
echo "Contenu du cours CPP 3" | hdfs dfs -put - /BDDC/CPP/Cours/CoursCPP3

# Étape 3
echo "Affichage du contenu des fichiers..."
hdfs dfs -cat /BDDC/CPP/Cours/CoursCPP1
hdfs dfs -cat /BDDC/CPP/Cours/CoursCPP2
hdfs dfs -cat /BDDC/CPP/Cours/CoursCPP3

# Étape 4
echo "Copie des fichiers vers JAVA..."
hdfs dfs -cp /BDDC/CPP/Cours/CoursCPP1 /BDDC/JAVA/Cours/
hdfs dfs -cp /BDDC/CPP/Cours/CoursCPP2 /BDDC/JAVA/Cours/
hdfs dfs -cp /BDDC/CPP/Cours/CoursCPP3 /BDDC/JAVA/Cours/

# Étape 5
echo "Suppression et renommage..."
hdfs dfs -rm /BDDC/JAVA/Cours/CoursCPP3
hdfs dfs -mv /BDDC/JAVA/Cours/CoursCPP1 /BDDC/JAVA/Cours/CoursJAVA1
hdfs dfs -mv /BDDC/JAVA/Cours/CoursCPP2 /BDDC/JAVA/Cours/CoursJAVA2

# Étape 6
echo "Création des fichiers locaux..."
mkdir -p /tmp/tp_files
echo "Contenu TP1 CPP" > /tmp/tp_files/TP1CPP
echo "Contenu TP2 CPP" > /tmp/tp_files/TP2CPP
echo "Contenu TP1 JAVA" > /tmp/tp_files/TP1JAVA
echo "Contenu TP2 JAVA" > /tmp/tp_files/TP2JAVA
echo "Contenu TP3 JAVA" > /tmp/tp_files/TP3JAVA

# Étape 7
echo "Copie des fichiers CPP vers HDFS..."
hdfs dfs -put /tmp/tp_files/TP1CPP /BDDC/CPP/TPs/
hdfs dfs -put /tmp/tp_files/TP2CPP /BDDC/CPP/TPs/

# Étape 8
echo "Copie des fichiers JAVA vers HDFS..."
hdfs dfs -put /tmp/tp_files/TP1JAVA /BDDC/JAVA/TPs/
hdfs dfs -put /tmp/tp_files/TP2JAVA /BDDC/JAVA/TPs/

# Étape 9
echo "Affichage récursif du contenu..."
hdfs dfs -ls -R /BDDC

# Étape 10
echo "Suppression de TP1CPP..."
hdfs dfs -rm /BDDC/CPP/TPs/TP1CPP

# Étape 11
echo "Suppression du répertoire JAVA..."
hdfs dfs -rm -r /BDDC/JAVA

# Vérification finale
echo "Vérification finale..."
hdfs dfs -ls -R /BDDC
EOF

chmod +x /tmp/hdfs_tp.sh