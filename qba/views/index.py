from django.shortcuts import render
from django.http import HttpResponse, JsonResponse


class IndexView(object):

    """docstring for IndexView"""

    def index(request):
        return render(request, 'qba/index.html')
        # return HttpResponse('Hellp HttpResponse...')
