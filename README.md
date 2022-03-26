# ADD_Auto_Mobile_Environment
국방과학연구소 무인수색차량 자율주행성능입증장치 개발

## Weather_automation.m
> 가상 주행환경 구축 프로그램인 PreScan과 MATLAB 연동한 시나리오 자동화 스크립트
> ![image](https://user-images.githubusercontent.com/36038244/147515243-1ac31091-0b7b-4d49-891d-018218d48d78.png) <br>
> (1) KCEI의 지역, 날씨 조건 부여 에뮬레이터 PC와 UDP 통신 IP, Port 설정 및 응답 대기시간은 10초로 설정 <br>
> (2) 조건 부여 에뮬레이터로부터 들어오는 [32 * 1] 크기의 데이터를 각각 변수로 구분 <br> <br>
> ![image](https://user-images.githubusercontent.com/36038244/147515373-d18e9158-a634-4d0e-99f6-344e90f67777.png) <br>
> (3) 각 지형별 PreScan 시나리오들이 있는 폴더로 이동 <br>
> (4) 지형별 리스트화함으로서, KCEI 지역, 날씨 조건 부여 에뮬레이터와 연동하여 시나리오 실행 가능 <br> <br>
> ![image](https://user-images.githubusercontent.com/36038244/147515531-53e8e23c-9652-4f6f-bf6e-970e1185af11.png) <br>
> (5) 에뮬레이터에서 지형 정보 설정 후 데이터를 전송하면 PreScan CLI (Command Line Interface)가 리스트화 되어있는 지형 이름으로 시나리오 실행 <br>
> (6) PreScan CLI 명령어를 통해 시나리오를 'Run_Temp'의 이름으로 시나리오 실행 (29 ~ 139) <br> <br>
> ![image](https://user-images.githubusercontent.com/36038244/147515757-7445cfa3-af4b-4e72-b42d-115968f41122.png) <br>
> (7) PreScan TestAutomation에서 설정한 날씨 tag를 matlab automation 스크립트에 입력 <br>
> (8) tag의 1번 - Weather_Type, 2번 - 눈, 3번 - 맑음, 4번 - 비로 설정 <br>
> (9) 세부 tag로 기상조건 
> > - 눈 : "Default Light_Snow","Default Moderate_Snow","Default Heavy_Snow","Default Extreme_Snow"로 지정
> > - 비 : "Rain_Type","Default Drizzle","Default Very_Light_Rain","Default Light_Rain",<br>"Default Moderate_Rain","Default Heavy_Rain","Default Very_Heavy_Rain","Default Extreme_Rain"로 지정 <br>
>
> ![image](https://user-images.githubusercontent.com/36038244/147515962-817381d6-1ae6-4c1c-8508-c235190f1605.png) <br>
> (10) 안개는 "Default Normal","Default High","Default Low"로 지정 <br>
> (11) 광량 (Intensity)은 에뮬레이터에서 설정한 값을 전송받아 설정 <br>
>
> ![image](https://user-images.githubusercontent.com/36038244/147516167-6fd41be0-02a9-49a2-ba51-b0fbbfd97e5d.png) <br>
> (12) PreScan CLI를 통해 만들어진 시나리오를 Simulink 파일로 build (130 ~ 131번 라인) <br>
> (13) Build 된 Simulink 파일을 실행 후 regenerate로 에뮬레이터에서 받은 정보들로 Simulink 파일 재생성 후 실행

