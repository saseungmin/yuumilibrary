package com.yuumilibrary.member.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.yuumilibrary.member.vo.MemberSearchVO;
import com.yuumilibrary.member.vo.MemberVO;

@Mapper
public interface IMemberDao {
	/**
	  * 회원테이블 목록 조회
	 * @return 회원목록
	 * @throws SQLException
	  */
	public List<MemberVO> getMemberList(MemberSearchVO searchVO) throws SQLException;
	
	/**
	  * 
	  * 요청한 <b>회원아이디</b>에 해당하는 회원을 조회한다.
	 * @param memId
	 * @return MemberVO
	 * @throws SQLException
	  */
	public MemberVO getMemberVO(String memId);
	
	/**
	  * 회원등록
	 * @param member
	 * @return int
	 * @throws SQLException
	  */
	public int insertMember(MemberVO member);
	
	/**
	  * 회원 정보 수정<br>
	  * 비밀번호 정보는 수정되지 않음
	 * @param member
	 * @return int
	 * @throws SQLException
	 */
	public int updateMember(MemberVO member) throws SQLException;
	
	/**
	  * 회원탈퇴<br>
	  * 회원테이블의 mem_del_yn을  "Y"로 변경
	 * @param member
	 * @return int
	 * @throws SQLException
	 */
	public int deleteMember(MemberVO member) throws SQLException;
	
	public int getMemberCount(MemberSearchVO searchVO)throws SQLException;
	
	
	/**
	  * 회원비밀키
	 * @param member
	 * @return int
	  */
	public int privateKeyMember(MemberVO member);
	/**
	  * 회원비밀키 삭제
	 * @param member
	 * @return int
	  */
	public int deletePrivatKey(String memId);
	
	/**
	 * 프로필 이미지 업로드
	 * @param member
	 * @return int
	 */
	public int updateMemberImg(MemberVO member);
	
	public List<MemberVO> getMemberListForExcel() throws SQLException;
	
	
}
