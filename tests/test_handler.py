"""Comprueba el contrato que API Gateway recibe de Lambda."""
import json
import unittest

from app.handler import lambda_handler


class HandlerTests(unittest.TestCase):
    def test_nombre_utec(self):
        response = lambda_handler({"queryStringParameters": {"name": "UTEC"}}, None)
        self.assertEqual(response["statusCode"], 200)
        self.assertEqual(response["headers"]["Content-Type"], "application/json")
        self.assertEqual(json.loads(response["body"])["message"], "Hello, UTEC!")

    def test_sin_query(self):
        response = lambda_handler({}, None)
        self.assertEqual(json.loads(response["body"])["message"], "Hello, World!")

    def test_query_nulo_de_api_gateway(self):
        response = lambda_handler({"queryStringParameters": None}, None)
        self.assertEqual(json.loads(response["body"])["message"], "Hello, World!")

    def test_nombre_con_unicode(self):
        response = lambda_handler({"queryStringParameters": {"name": "Aarón"}}, None)
        self.assertEqual(json.loads(response["body"])["message"], "Hello, Aarón!")


if __name__ == "__main__":
    unittest.main()
