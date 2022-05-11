============= STEP DEPLOY ===============
1. Deploy Zookeeper: create configmap as needed
2. Create cert: run script to create CA, <Company>.trust, admin.key
3. Deploy Kafka: create configmap as needed
4. Run command in "COMMAND FORCE" then restart Kafka ( delete pod :"> )


============= COMMAND FORCE =============
kafka-configs --zookeeper zookeeper-cluster-0.zookeeper-headless.<namespace>:22181 --alter --add-config 'SCRAM-SHA-256=[iterations=4096,password=password]' --entity-type users --entity-name metricsreporter

kafka-configs --zookeeper zookeeper-cluster-0.zookeeper-headless.<namespace>:22181 --alter --add-config 'SCRAM-SHA-256=[iterations=4096,password=password]' --entity-type users --entity-name kafkaclient

kafka-configs --zookeeper zookeeper-cluster-0.zookeeper-headless.<namespace>:22181 --alter --add-config 'SCRAM-SHA-256=[iterations=4096,password=password]' --entity-type users --entity-name kafkabroker

============= COMMAND KAFKA =============
# Create new user
kafka-configs --zookeeper zookeeper-cluster-0.zookeeper-headless.log-service:22181 --alter --add-config 'SCRAM-SHA-256=[iterations=4096,password=hoanm-secret]' --entity-type users --entity-name hoanm

# Grant ACL for producer and consumer

# Producer
kafka-acls --authorizer-properties zookeeper.connect=zookeeper-cluster-0.zookeeper-headless.log-service:22181 --add --topic hoanm --producer --allow-principal=User:hoanm

# Consummer
kafka-acls --authorizer-properties zookeeper.connect=zookeeper-cluster-0.zookeeper-headless.log-service:22181 --add --topic hoanm --consumer --group '*' --allow-principal=User:hoanm 

# File config user.properties

ssl.truststore.location=/etc/kafka/secrets/<Company>.trust
ssl.truststore.password=bQEq9BdeW

ssl.keystore.location=/etc/kafka/secrets/hoanm.key
ssl.keystore.password=123123hihi

ssl.key.password=123123hihi
ssl.endpoint.identification.algorithm=

sasl.mechanism=SCRAM-SHA-256
security.protocol=SASL_SSL

sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
        username="hoanm" \
        password="hoanm-secret";
