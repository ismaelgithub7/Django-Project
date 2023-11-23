from django.test import TestCase
from django.urls import reverse

class CalculatorTests(TestCase):
    def test_home_view_status_code(self):
        response = self.client.get(reverse('home'))
        self.assertEqual(response.status_code, 200)

    def test_addition(self):
        data = {'num1': '2', 'num2': '3', 'operation': 'add'}
        response = self.client.post(reverse('calculate'), data)
        self.assertContains(response, 'Resultado: 5')

    def test_subtraction(self):
        data = {'num1': '5', 'num2': '2', 'operation': 'subtract'}
        response = self.client.post(reverse('calculate'), data)
        self.assertContains(response, 'Resultado: 3')

    def test_multiplication(self):
        data = {'num1': '4', 'num2': '3', 'operation': 'multiply'}
        response = self.client.post(reverse('calculate'), data)
        self.assertContains(response, 'Resultado: 12')

    def test_division(self):
        data = {'num1': '8', 'num2': '2', 'operation': 'divide'}
        response = self.client.post(reverse('calculate'), data)
        self.assertContains(response, 'Resultado: 4')

    def test_invalid_input(self):
        data = {'num1': 'abc', 'num2': '2', 'operation': 'add'}
        response = self.client.post(reverse('calculate'), data)
        self.assertContains(response, 'Por favor, introduce números válidos.')
