from django.models import models
from datetime import datetime, date
import random
import uuid

# from basic import settings
# from decimal import Decimal


class Root(models.Model):
    entry_date = models.DateTimeField(auto_now=True)

    @property
    def json(self, format='yyyy-MM-dd HH:mm'):
        data = {}
        for key, value in self.__dict__.items():
            if key != '_state':
                if isinstance(value, datetime.datetime):
                    data[
                        key] = '{}-{}-{} {}:{}'.format(value.year, value.month, value.day, value.hour, value.minute)
                else:
                    data[key] = str(value)
        return data

    def jn(self, *args):
        data = {}
        for key, value in self.__dict__.items():
            if args and key not in args:
                continue
            elif key != '_state':
                if isinstance(value, datetime.datetime):
                    data[
                        key] = '{}-{}-{} {}:{}'.format(value.year, value.month, value.day, value.hour, value.minute)
                else:
                    data[key] = str(value)
        return data

    def as_option(self, value, text, selected=''):
        return '<option value="{}" {}>{}</option>'.format(getattr(self, value), selected, getattr(self, text))

    class Meta:
        abstract = True
