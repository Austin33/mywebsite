from django.urls import path
from groundzero import views


urlpatterns = [
    path(r'', views.HomePageView.as_view()),
]