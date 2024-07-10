# Generated by Django 5.0.7 on 2024-07-09 23:44

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="Submission",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("data_uri", models.CharField(max_length=4096)),
                (
                    "status",
                    models.CharField(
                        choices=[
                            ("NOT_STARTED", "Not Started"),
                            ("UPLOADING", "Uploading"),
                            ("UPLOADED", "Uploaded"),
                            ("CLEARED", "Cleared"),
                        ],
                        default="NOT_STARTED",
                        max_length=16,
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="Evaluation",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("evaluator_state", models.JSONField()),
                ("result", models.JSONField()),
                (
                    "status",
                    models.CharField(
                        choices=[
                            ("NOT_STARTED", "Not Started"),
                            ("EVALUATING", "Evaluating"),
                            ("EVALUATED", "Evaluated"),
                            ("HIDDEN", "Hidden"),
                        ],
                        default="NOT_STARTED",
                        max_length=16,
                    ),
                ),
                (
                    "submission",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE, to="web.submission"
                    ),
                ),
            ],
        ),
    ]
