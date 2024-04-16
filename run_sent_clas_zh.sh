#!/bin/bash

TASKS=( "tnews" "afqmc" "iflytek" "cmnli")
# MODELS=("base" "freelb" "smart" "r3f" "creat")
MODELS=("base")
SEEDS=(42)

DATA_DIR="/media/HD1/CreAT/data/clue-roc/"
OUTPUT_DIR="/media/HD1/CreAT/output-roc/macbert-base-chinese/"

TRAIN_BATCH_SIZE=32
EVAL_BATCH_SIZE=32
DEVICE="cuda:0"
MODEL_PATH='/media/HD1/CreAT/macbert-base'

for task in "${TASKS[@]}"; do
  for model in "${MODELS[@]}"; do
    for seed in "${SEEDS[@]}"; do
      OUTPUT_SUBDIR="$OUTPUT_DIR/$task/$model/seed$seed"
      mkdir -p "$OUTPUT_SUBDIR"
      
      python run_sent_clas.py \
        --data_dir "$DATA_DIR" \
        --task_name "$task" \
        --output_dir "$OUTPUT_SUBDIR" \
        --train_batch_size "$TRAIN_BATCH_SIZE" \
        --eval_batch_size "$EVAL_BATCH_SIZE" \
        --load_model_path "$MODEL_PATH" \
        --device "$DEVICE" \
        --seed "$seed"
    done
  done
done