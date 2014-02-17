echo "Setting the symbolic link resolution behavoir...";
fsutil behavior set SymlinkEvaluation L2L:1 R2R:1 L2R:1 R2L:1
pause
