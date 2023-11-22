from django.shortcuts import render
from django.http import HttpResponse

def home(request):
    return render(request, 'calculator_app/home.html')

def calculate(request):
    if request.method == 'POST':
        try:
            num1 = float(request.POST['num1'])
            num2 = float(request.POST['num2'])
            operation = request.POST['operation']

            if operation == 'add':
                result = num1 + num2
            elif operation == 'subtract':
                result = num1 - num2
            elif operation == 'multiply':
                result = num1 * num2
            elif operation == 'divide':
                result = num1 / num2
            else:
                result = None

            return render(request, 'calculator_app/home.html', {'result': result, 'num1': num1, 'num2': num2, 'operation': operation})

        except ValueError:
            return render(request, 'calculator_app/home.html', {'error': 'Por favor, introduce números válidos.'})

    return HttpResponse("Método no permitido")

