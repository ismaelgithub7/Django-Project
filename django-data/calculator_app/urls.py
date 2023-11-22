from django.urls import path
from .views import home, calculate

urlpatterns = [
    path('', home, name='home'),
    path('calculate/', calculate, name='calculate'),
]
