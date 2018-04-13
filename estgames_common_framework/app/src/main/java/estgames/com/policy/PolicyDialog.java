package estgames.com.policy;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.NonNull;

/**
 * Created by mp on 2018. 3. 13..
 */
/*TODO
    json으로 데이터 가져오기
    다이얼로그
    제목
    중간제목
    웹뷰 2개
    버튼 2개
    화면 크기 고려
    가로, 세로 화면
Activity가 갖고 있는 getResources()함수를 이용하여 리소스를 불러온 뒤 getConfiguration() 을 이용하시면 됩니다.
getResources().getConfiguration().orientation
 댓글 2011.03.23 17:57:30
즐겁게살자
전 전에 Display의 getRotation()으로 초기 값을 구했었습니다.
 */
public class PolicyDialog extends Dialog {
    public PolicyDialog(@NonNull Context context) {
        super(context);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //this.getContext().getResources().getConfiguration().orientation
    }
}
/*
* if(this.getResources().getConfiguration().orientation == Configuration.ORIENTATION_PORTRAIT)
{
  // 세로 모드
}else if(this.getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE)
  // 가로 모드
}
* */