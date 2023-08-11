# AWS SDK Crash Example

A minimal example for [#1077](https://github.com/awslabs/aws-sdk-swift/issues/1077) demonstrating a fatal error that occurs when attempting to use AWS SES and DynamoDB concurrently in a Lambda. Concurrent use of those services causes the following error (from the CloudWatch logs for the function):

```
ClientRuntime/SDKDefaultIO.swift:70: Fatal error: Tls Context failed to create. This should never happen.Please open a
Github issue with us at https://github.com/awslabs/aws-sdk-swift.
RequestId: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx Error: Runtime exited with error: signal: trace/breakpoint trap Runtime.ExitError
```