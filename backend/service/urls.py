from django.conf.urls import url
from service import views

urlpatterns = [
    url(r'^service/$', views.ServiceList.as_view()),
    url(r'^servicesms/$', views.ServiceSMSList.as_view()),
]
