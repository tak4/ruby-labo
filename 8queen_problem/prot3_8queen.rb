# ８王妃問題を解く

# 盤面の大きさ
DEF_BOARD_SIZE=8

# Queen配置不可の位置を示すフラグ
$flag_a = Array.new(DEF_BOARD_SIZE,0)		# 同じ行には配置しない
$flag_b = Array.new(15,0)					# 斜め/の向きの位置には配置しない
$flag_c = Array.new(15,0)					# 斜め\の向きの位置には配置しない

# Queenの位置 一つの盤面のQueenの位置を1行分の配列で表す
# 例
# pos[] =  7 3 0 2 5 1 6 4
#  □□■□□□□□
#  □□□□□■□□
#  □□□■□□□□
#  □■□□□□□□
#  □□□□□□□■
#  □□□□■□□□
#  □□□□□□■□
#  ■□□□□□□□
$pos = Array.new(DEF_BOARD_SIZE,0) 

# Queenの位置を出力
def _print
	for i in 0..DEF_BOARD_SIZE-1
		printf("%2d", $pos[i])
	end
	print("\n")
end

# Queenの位置を出力 盤面のイメージで出力
def _print_visual
	for j in 0..DEF_BOARD_SIZE-1
		for i in 0..DEF_BOARD_SIZE-1
			if j == $pos[i]
				printf("■")
			else
				printf("□")
			end
		end
		printf("\n")
	end
end

# Queenを配置する
# $pos[] に i,j でQueenの配置位置を表す
# ----------> i
# |
# |
# |
# j
#
def set(i)
#	printf("set(%d) call\n", i)		# debug
	for j in 0..DEF_BOARD_SIZE-1
		# Queen配置不可の位置には配置しない 
		# 配置位置組み合わせ 8^8=16777216とおりの組み合わせから条件似合うものだけを配置
		if $flag_a[j] == 0 && $flag_b[i+j] == 0 && $flag_c[i-j+7] == 0 then
#			printf("i=%d, j=%d\n", i, j)	# debug
			$pos[i] = j		#各行のQueenの位置
			if i == DEF_BOARD_SIZE-1 then
				_print
				_print_visual
			else
				$flag_a[j]=$flag_b[i+j]=$flag_c[i-j+7]=1
				set(i+1)		#次の列へ
				$flag_a[j]=$flag_b[i+j]=$flag_c[i-j+7]=0
			end
		end
	end
#	printf("set(%d) return\n", i)	# debug
end

# 0列目から開始
set(0)

