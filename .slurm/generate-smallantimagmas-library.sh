#!/bin/bash
#SBATCH -p ampere
#SBATCH -t 1-00:00:00
#SBATCH -o /storage/limakzi/logs/gap-stdout-%j.txt
#SBATCH -e /storage/limakzi/logs/gap-stderr-%j.txt
#SBATCH --array=1-400

../../../gap -r -b -q << EOF
LoadPackage("smallantimagmas");
__SmallAntimagmaHelper.SaveData($ORDER, __SmallAntimagmaHelper.SplitInteger($ORDER, 400, $SLURM_ARRAY_TASK_ID));
EOF
