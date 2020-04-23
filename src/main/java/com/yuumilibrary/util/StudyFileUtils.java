package com.yuumilibrary.util;

import java.text.DecimalFormat;

public class StudyFileUtils {
	
	//1024보다 작으면 구냥 byte붙여서 리턴
	//1048576(1024*1024)보다 작으면 size/1024kb
	//그외 Mb로 리턴
	//fancySize(7492) ->"7.52kb"
	//fanceSize(390)->"390Byte"
	public static String fancySize(long size) {
		DecimalFormat fmt = new DecimalFormat("0.##");
		if(size<1024) {
			return size+"byte";
			
		}else if(size<1048576) {
			double sizet=size/1024.0;
			return fmt.format(sizet)+"kb";
		}else {
			return fmt.format(size/1048576.0)+"Mb";
		}
	}
}
