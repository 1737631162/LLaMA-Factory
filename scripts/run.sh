#! /usr/bin/env bash

llamafactory-cli train --stage sft --do_train True --model_name_or_path Qwen2.5-1.5B-Instruct --preprocessing_num_workers 16 --finetuning_type lora --template qwen --flash_attn auto --dataset_dir data --dataset remote_controll_toolcall_v10 --cutoff_len 2048 --learning_rate 5e-05 --num_train_epochs 6.0 --max_samples 100000 --per_device_train_batch_size 3 --gradient_accumulation_steps 8 --lr_scheduler_type cosine --max_grad_norm 1.0 --logging_steps 5 --save_steps 100 --warmup_steps 0 --packing False --report_to none --output_dir $output_dir --bf16 True --plot_loss True --ddp_timeout 180000000 --include_num_input_tokens_seen True --optim adamw_torch --lora_rank 8 --lora_alpha 16 --lora_dropout 0 --lora_target all

# llamafactory-cli export --model_name_or_path Qwen2.5-1.5B-Instruct --adapter_name_or_path LLaMA-Factory/saves/Qwen2.5-1.5B-Instruct/lora/train_hao1 --template qwen --finetuning_type lora --export_dir megred-model-path/v1_lora --export_size 2 --export_device cpu --export_legacy_format False
# llamafactory-cli api --model_name_or_path LLaMA-Factory/megred-model-path/v1_lora --template qwen
