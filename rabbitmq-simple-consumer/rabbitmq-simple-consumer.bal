import ballerina/log;
import ballerina/rabbitmq;

// Creates a ballerina RabbitMQ connection that allows reusability if necessary.
rabbitmq:Connection connection = new({ host: "localhost", port: 5672 });

listener rabbitmq:ChannelListener channelListener = new(connection);

// Consumer service listens to the "testQueue" queue.
@rabbitmq:ServiceConfig {
    queueConfig: {
        queueName: "testQueue"
    }
}
// Attaches the service to the listener.
service testSimpleConsumer on channelListener {

    // Gets triggered when a message is received by the queue.
    resource function onMessage(string message) {
        log:printInfo("The message received: " + message);
    }
}
