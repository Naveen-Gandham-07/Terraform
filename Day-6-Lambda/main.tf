resource "aws_lambda_function" "my_lambda" {
  function_name = "simple_lambda"

  role    = "arn:aws:iam::641867104819:role/lambda-exce"  # <-- replace
  handler = "index.lambda_handler"
  runtime = "python3.9"

  filename         = "lambda_function.zip"
  source_code_hash = filebase64sha256("lambda_function.zip")

  timeout = 900
}