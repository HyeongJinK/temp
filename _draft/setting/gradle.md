# gradle 파일 의존성 설정

안드로이드 프로젝트는 기본적으로 gradle을 기반으로 프로젝트를 구성합니다.
EGMP SDK를 사용하기 위해 build.gradle 파일에 의존성 정보를 등록합니다.

* <span style="color: red">해당 라이브러리는 코틀린로 작성되었습니다. 코틀린 런타임 라이브러리를 적용해주세요.</span>
    * 'org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.+'

* Appication 클래스 작성에 필요한 라이브러리
    * 'com.android.support:multidex:1.0.1' 
    * 'com.android.support.constraint:constraint-layout:1.1.2'

* SNS 계정연동에 사용되는 라이브러리
    * 'com.google.android.gms:play-services-auth:15.0.1'
    * 'com.facebook.android:facebook-login:[4, 5)'
* EstGame 라이브러리(제공되는 aar 파일을 app/libs 폴더에 넣어주세요.)
    * implementation 'com.estgames.framework:mp-aos-sdk-release:1.0@aar'

* defaultConfig에 applicationId에 있는 패키지명을 해당게임에 맞는 패키지명을 일치 시켜주어야 구글 로그인이 가능합니다. 자세한 패키지명은 웹플랫폼팀에 문의 부탁드립니다.



##### build.gradle
```gradle
defaultConfig {
        applicationId "$app_package_name"         
        .
        .
        .
    }

dependencies {
    .
    .
    .

    implementation 'org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.+'

    implementation 'com.android.support:multidex:1.0.1'
    implementation 'com.android.support.constraint:constraint-layout:1.1.2'

    implementation 'com.google.android.gms:play-services-auth:15.0.1'
    implementation 'com.facebook.android:facebook-login:[4, 5)'

    implementation 'com.estgames.framework:mp-aos-sdk-release:2.0@aar'
}

//app/libs 폴더에 넣은 aar파일을 읽기 위한 설정
repositories {
    flatDir {
        dirs 'libs'
    }
}
```