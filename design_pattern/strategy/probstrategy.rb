class ProbStrategy < Strategy

	# �R���X�g���N�^
	def initialize
		# �O��o������,����o���� => ������
		# �񎟌��z����n�b�V���Ŏ�������
		@history = {
			'0,0' => 1,
			'0,1' => 1,
			'0,2' => 1,
			'1,0' => 1,
			'1,1' => 1,
			'1,2' => 1,
			'2,0' => 1,
			'2,1' => 1,
			'2,2' => 1,
		}
		@current_hand_value = 0
	end
	
	def next_hand()
		# �ߋ��̏������ō���̎�����肷��
		bet = rand(get_sum(@current_hand_value))
		hand_value = 0
		if (bet < @history["#{@current_hand_value},0"]) then
			hand_value = 0
		elsif (bet < @history["#{@current_hand_value},0"] + @history["#{@current_hand_value},1"]) then
			hand_value = 1
		else
			hand_value = 2
		end
		
		@prev_hand_value = @current_hand_value
		@current_hand_value = hand_value
		return Hand.get_hand(hand_value)
	end
	
	def study(win)
		if (win == true)
			# �������炻�̎�ł̏������A�b�v����
			@history["#{@prev_hand_value},#{@current_hand_value}"] += 1
		else
			# �������񂾂��ǁA���ĂĂ�����̏������A�b�v����
			possible_to_win1 = (@current_hand_value + 1) % 3
			possible_to_win2 = (@current_hand_value + 2) % 3
			@history["#{@prev_hand_value},#{possible_to_win1}"] += 1
			@history["#{@prev_hand_value},#{possible_to_win2}"] += 1
		end
	end
	
	def get_sum(hv)
		sum = 0
		for i in 0..2
			sum += @history["#{hv},#{i}"]
		end
		return sum
	end
	
	private :get_sum
end
