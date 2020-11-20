package com.study.web.dao;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.study.web.vo.Board;
public interface BoardDAO {

	public List<Board> board_list(HashMap<String, Object> map) throws Exception; // �� ���

	public List<Board> notice_list(HashMap<String, Object> map);
	
	public int getCount(HashMap<String, Object> map);
	
	public Board board_read(int bNum) throws Exception; // �Խñ� ����
	
	public Board board_mod(int bNum) throws Exception; // �Խñ� ���� ����

	
	// �Խñ� �ۼ�
	public void board_write(Board board)throws Exception;

	// �Խñ� ����
	public void board_update(Board board)throws Exception;
	
	// �Խñ� ����
	public void board_delete(int bNum) throws Exception;
}
