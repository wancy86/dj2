from django.db import models
from root_model import Root
import uuid

class Player(Root):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    password = models.CharField(max_length=50)
    referral_code = models.CharField(max_length=50)
    referral_by = models.CharField(max_length=50, default='')

    email = models.EmailField(default='')
    cell_phone = models.CharField(max_length=50, default='')

    full_name = models.CharField(max_length=50, default='')
    birthday = models.DateField()
    gender = models.CharField(max_length=50, default='')
    region = models.CharField(max_length=255, default='')
    region_name = models.CharField(max_length=255, default='')
    # 备用字段
    user_name = models.CharField(max_length=30)
    first_name = models.CharField(max_length=50, default='')
    last_name = models.CharField(max_length=50, default='')
    zip_code = models.CharField(max_length=50, default='')