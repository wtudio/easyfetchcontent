#include <string>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern "C" {
#include "MQTTClient.h"
}

#if !defined(_WIN32)
  #include <unistd.h>
#else
  #include <windows.h>
#endif

#define ADDRESS "tcp://mqtt.eclipseprojects.io:1883"
#define CLIENTID "ExampleClientPub"
#define TOPIC "MQTT Examples"
#define QOS 1
#define TIMEOUT 10000L

MQTTClient_deliveryToken deliveredtoken;

void delivered(void *context, MQTTClient_deliveryToken dt) {
  printf("Message with token value %d delivery confirmed\n", dt);
  deliveredtoken = dt;
}

int msgarrvd(void *context, char *topicName, int topicLen, MQTTClient_message *message) {
  printf("Message arrived\n");
  printf("     topic: %s\n", topicName);
  printf("   message: %.*s\n", message->payloadlen, (char *)message->payload);
  MQTTClient_freeMessage(&message);
  MQTTClient_free(topicName);
  return 1;
}

void connlost(void *context, char *cause) {
  printf("\nConnection lost\n");
  printf("     cause: %s\n", cause);
}

int main(int argc, char *argv[]) {
  MQTTClient client;
  MQTTClient_connectOptions conn_opts = MQTTClient_connectOptions_initializer;
  MQTTClient_message pubmsg = MQTTClient_message_initializer;
  MQTTClient_deliveryToken token;
  int rc;

  if ((rc = MQTTClient_create(&client, ADDRESS, CLIENTID,
                              MQTTCLIENT_PERSISTENCE_NONE, NULL)) != MQTTCLIENT_SUCCESS) {
    printf("Failed to create client, return code %d\n", rc);
    rc = EXIT_FAILURE;
    return -1;
  }

  if ((rc = MQTTClient_setCallbacks(client, NULL, connlost, msgarrvd, delivered)) != MQTTCLIENT_SUCCESS) {
    printf("Failed to set callbacks, return code %d\n", rc);
    rc = EXIT_FAILURE;
    MQTTClient_destroy(&client);
    return -1;
  }

  conn_opts.keepAliveInterval = 20;
  conn_opts.cleansession = 1;
  if ((rc = MQTTClient_connect(client, &conn_opts)) != MQTTCLIENT_SUCCESS) {
    printf("Failed to connect, return code %d\n", rc);
    rc = EXIT_FAILURE;
    MQTTClient_destroy(&client);
    return -1;
  }

  std::string payload("hello world!");

  pubmsg.payload = payload.data();
  pubmsg.payloadlen = payload.size();
  pubmsg.qos = QOS;
  pubmsg.retained = 0;
  deliveredtoken = 0;
  if ((rc = MQTTClient_publishMessage(client, TOPIC, &pubmsg, &token)) != MQTTCLIENT_SUCCESS) {
    printf("Failed to publish message, return code %d\n", rc);
    rc = EXIT_FAILURE;
  } else {
    printf(
        "Waiting for publication of %s\n"
        "on topic %s for client with ClientID: %s\n",
        payload.c_str(), TOPIC, CLIENTID);
    while (deliveredtoken != token) {
#if defined(_WIN32)
      Sleep(100);
#else
      usleep(10000L);
#endif
    }
  }

  if ((rc = MQTTClient_disconnect(client, 10000)) != MQTTCLIENT_SUCCESS) {
    printf("Failed to disconnect, return code %d\n", rc);
    rc = EXIT_FAILURE;
  }

  return 0;
}
