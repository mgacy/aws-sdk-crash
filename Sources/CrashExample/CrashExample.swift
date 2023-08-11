import AWSDynamoDB
import AWSLambdaEvents
import AWSLambdaRuntime
import AWSSES
import Foundation

@main
struct ExampleLambda: SimpleLambdaHandler {
    func handle(_ event: APIGatewayV2Request, context: LambdaContext) async throws -> APIGatewayV2Response {
        context.logger.info("RECEIVED: \(event)")

        async let putResponse = try await persistItem("us-east-1", tableName: "Test")
        async let emailResponse = try await sendEmail(to: "example@mail.com", from: "example@mail.com")
        let (putOutput, emailOutput) = try await (putResponse, emailResponse)
        context.logger.info("SAVED: \(putOutput) and SENT: \(emailOutput)")

        return APIGatewayV2Response(statusCode: .ok)
    }
}

extension ExampleLambda {
    func sendEmail(to recipient: String, from sender: String) async throws -> SendEmailOutputResponse {
        let sesClient = try await SESClient()
        let email = SendEmailInput(
            destination: SESClientTypes.Destination(toAddresses: [recipient]),
            message: SESClientTypes.Message(
                body: SESClientTypes.Body(text: SESClientTypes.Content(data: "Test")),
                subject: SESClientTypes.Content(data: "Testing ...")),
            replyToAddresses: nil,
            returnPath: nil,
            source: sender
        )
        return try await sesClient.sendEmail(input: email)
    }

    func persistItem(_ region: String, tableName: String) async throws -> PutItemOutputResponse {
        let dbClient = try DynamoDBClient(region: region)
        let item: [String: DynamoDBClientTypes.AttributeValue] = [
            "CreatedAt": .s(ISO8601DateFormatter().string(from: Date()))
        ]
        return try await dbClient.putItem(input: PutItemInput(
            item: item,
            tableName: tableName))
    }
}
