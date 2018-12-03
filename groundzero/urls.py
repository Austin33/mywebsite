from django.conf.urls import url
from groundzero import views


urlpatterns = [
    url(r'^$', views.HomePageView.as_view()),
]