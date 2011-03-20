//#include "stdafx.h"
/*
 *
gcc -D DLL -shared -o ../plugin/vjde/tipswnd.dll tipswnd.c -luser32 -lcomctl32 -lgdi32 -mwindows
 */
#include <windows.h>
#ifdef DLL
#define _DL_EXPORT __declspec(dllexport) extern
#else
#define _DL_EXPORT
#endif

char cBuffer[2048];
int iLineCount;
int top ;
int left;
int iMaxWidth;
int iMaxHeight;
BOOL stoped ;

HWND hwndText; // Vim ���봰��
HWND m_vimHwnd; // vim ����

BOOL CALLBACK EnumWndProc(HWND hWnd,LPARAM lParam)
{
	HWND* lhwnd=(HWND*)lParam;
	char buf[50];
	GetClassName(hWnd,buf,50);
	//VimTextArea is the class name of main editing window of VIM
	if (strcmp(buf,"VimTextArea") == 0)
	{
		*lhwnd=hWnd; 
		return FALSE;
	}
	return TRUE;
}
void FindVimWindow()
{
	HWND hTempHwnd = GetForegroundWindow();
	if(hTempHwnd)
	{
		m_vimHwnd = hTempHwnd;
	}
	else
	{
		//but getting VIM window failed get the Desktop window. This is used to get the 
		//VIM rectangle. So even desktop window is also OK.
		m_vimHwnd = GetDesktopWindow();
	}

	//Get the editing window in the VIM.
	EnumChildWindows(m_vimHwnd,EnumWndProc,(LPARAM)&hwndText);

	//GetWindowRect(hwndText,vimRect);
}
void PaintText(HDC hdc) 
{
	char *p = cBuffer;
	char *temp = cBuffer;
	int line = 0;
	while ( *temp != '\0') {
		if (*temp == '\n') {
			TextOut( hdc, 2 , iMaxHeight * line + 2, p, temp-p );//�������
			line ++;
			p = temp+1;
		}
		++temp;
	}
	if ( p < temp ) 
	{ //���δ����һ��\n
			TextOut( hdc, 2 , iMaxHeight * line + 2, p, temp-p );//�������
	}
}
BOOL RetriveTextSize(HDC hdc)
{
	SIZE size ;

	iLineCount = 0;
	iMaxWidth = 0;
	iMaxHeight = 0;

	char *p = cBuffer;
	char *temp = cBuffer;
	while ( *temp != '\0') {
		if (*temp == '\n') {
			iLineCount++;
			 GetTextExtentPoint(hdc,p,temp-p-1,&size);
		   	 {
			iMaxWidth = size.cx > iMaxWidth ? size.cx:iMaxWidth;
			iMaxHeight = size.cy > iMaxHeight ? size.cy:iMaxHeight;
			}
			p = temp+1;
		}
		++temp;
	}
	if ( p < temp ) 
	{ //���δ����һ��\n
		iLineCount++;
		 GetTextExtentPoint(hdc,p,temp-p-1,&size); 
		 {
			iMaxWidth = size.cx > iMaxWidth ? size.cx:iMaxWidth;
			iMaxHeight = size.cy > iMaxHeight ? size.cy:iMaxHeight;
		}
	}
}
int ReadInt(char *in,int l)
{
	char buffer[64];
	snprintf(buffer,l,"%s",in);
	return atoi(buffer);
}
int AdjustPosEx(LPRECT rect, int w,int h)
{
	if ( left+w+10 > rect->right ) {
		if ( left > w+10 ) {
			left = left - w - 10;
		}
		else {
			left = rect->right - w - 20;
		}
	}
	if ( top + h + 10 > rect->bottom ) {
		if ( top > h + 10 ) {
			top = top - h - 20;
		}
		else {
			top = rect->bottom - h - 20;
		}
	}
}
/**
 * Caculate the left-top point of tips window.
 * @param in "8;12;30;80;\n.."
 *            line;col; line total;colums total;
 */
int AdjustPos(LPRECT rect,char *in)
{
	int t,l,w,h;
	char *p = in;
	char *temp = in;
	char buffer[128];

	while ( *temp!=';') ++temp;
	t = ReadInt(p,temp-p);
	++temp;
	p = temp;

	while ( *temp!=';' ) ++temp;
	l = ReadInt(p,temp-p);
	++temp;
	p = temp;

	while ( *temp!=';' ) ++temp;
	h = ReadInt(p,temp-p);
	++temp;
	p = temp;

	while ( *temp!=';' ) ++temp;
	w = ReadInt(p,temp-p);
	++temp;
	++temp; // skip a \n

	top = (rect->bottom-rect->top)*t/h + rect->top;
	left = (rect->right-rect->left)*l/w + rect->left;
	return temp - in;

	//snprintf(buffer,64,p,
}
//һ����Ϣ������
//����:���ھ������Ϣ����Ϣ��������Ϣ����
LRESULT CALLBACK WndProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	//�������Ȥ����Ϣ
	switch (message)
	{
		case WM_KEYDOWN:
			switch (wParam)
			{
				stoped = TRUE;
				DestroyWindow(hwnd);
				return 0;
			}
		case WM_LBUTTONDOWN:
		case WM_RBUTTONDOWN://�����Ϣ
			{
				stoped = TRUE;
				DestroyWindow(hwnd);
				return 0;
			}
		case WM_PAINT:
			{
				char hello[]="��ã�����EasyWin !";
				char buff[128];
				HDC hdc;
				PAINTSTRUCT ps;
				RECT rect;
				HFONT font;
				HGDIOBJ oldFont;


			    font	= CreateFont(12, 0, 0, 0, FW_REGULAR, 0, 0, 0, 0, 0, 0, 0, 0, "MS Sans Serif");

				hdc=BeginPaint( hwnd,&ps ); //ȡ���豸�������

				oldFont = SelectObject(hdc,font);
				RetriveTextSize(hdc);

				GetWindowRect( GetDesktopWindow() , &rect);
				AdjustPosEx(&rect,iMaxWidth+20,iMaxHeight * iLineCount + 20);
				MoveWindow(hwnd,left,top, iMaxWidth+20,(iMaxHeight * iLineCount)+20,TRUE);


				GetClientRect(hwnd,&rect);
				InflateRect(&rect,-1,-1);
				FillRect(hdc, &rect,CreateSolidBrush(RGB(0xff,0xff,0x99)));

				SelectObject(hdc,CreatePen(PS_SOLID,2,RGB(162,162,162)));

				SetBkMode(hdc,TRANSPARENT);
				SetTextColor(hdc, RGB(0,0,0)); //����������ɫ

				oldFont = SelectObject(hdc,font);
				PaintText(hdc);

				SelectObject(hdc,oldFont);
				EndPaint( hwnd, &ps ); //�ͷ���Դ
				break;
			}
		case WM_CLOSE:
			break;
		case WM_DESTROY:
			//PostQuitMessage(0);
			//���û��رմ��ڣ��������٣���������������˳���Ϣ�����˳���Ϣѭ��
			return 0 ;
	}
	return 0;
	//������Ϣ������ϵͳ�ṩ��ȱʡ������
	return DefWindowProc(hwnd, message, wParam, lParam);
}

_DL_EXPORT int tipsWnd(char *in)
{
	//1.ע�ᴰ����
	static TCHAR szAppName[] = TEXT ("HelloWin") ; //����������
	//����"������"�ṹ

	//��������
	HWND hwnd ;
	RECT rect;

	FindVimWindow();
	GetWindowRect(hwndText,&rect);
	int offset = AdjustPos(&rect,in);
	//top = rect.top;
	//left = rect.left;
	//��������
	hwnd = CreateWindowEx(
			WS_EX_DLGMODALFRAME|WS_EX_TOOLWINDOW,
			//szAppName,
			"#32770",
			TEXT("The Hello Program"),
			WS_POPUP|WS_DLGFRAME|WS_OVERLAPPED,
			0,
			0,
			400,
			300,
			NULL,
			NULL,
			NULL,
			NULL);
	//sprintf(cBuffer,"%s","Hello \n world!\n�Ǿ����ڲ���.--------------------\n^_^\n");
	snprintf(cBuffer,2048,"%s",in+offset);
	SetWindowLongPtr(hwnd,DWL_DLGPROC,(LPARAM)WndProc);

	ShowWindow (hwnd, SW_SHOW) ;
	UpdateWindow (hwnd) ;

	//��Ϣѭ��
	MSG msg ;
	while (!stoped ) {
		if ( GetMessage(&msg,NULL,0,0)== 0 ) {
			break;
		}
		TranslateMessage (&msg) ; //ת����Ϣ
		DispatchMessage (&msg) ; //�ɷ���Ϣ
	}
	/*
	while (GetMessage (&msg, NULL, 0, 0)) //����Ϣ������ȡ��Ϣ
	{
		TranslateMessage (&msg) ; //ת����Ϣ
		DispatchMessage (&msg) ; //�ɷ���Ϣ
	}
	*/
	//UnregisterClass(szAppName,NULL);
	return strlen(in); ;
}
#ifndef DLL
//����Ӧ�ó���������
//����:ʵ�������ǰһ��ʵ���ľ���������в�����������ʾ��ʽ
int WINAPI WinMain (HINSTANCE hInstance, HINSTANCE hPrevInstance,
		PSTR szCmdLine, int iCmdShow)
{
	//1.ע�ᴰ����
	static TCHAR szAppName[] = TEXT ("HelloWin") ; //����������
	//����"������"�ṹ
	/*
	WNDCLASS wndclass ;
	wndclass.style = CS_HREDRAW | CS_VREDRAW ;
	wndclass.lpfnWndProc = WndProc ; //������Ϣ������
	wndclass.cbClsExtra = 0 ;
	wndclass.cbWndExtra = 0 ;
	wndclass.hInstance = hInstance ; //ʵ�����
	wndclass.hIcon = LoadIcon (NULL, IDI_APPLICATION) ; //ͼ��
	wndclass.hCursor = LoadCursor (NULL, IDC_ARROW) ; //���
	wndclass.hbrBackground = (HBRUSH) GetStockObject (WHITE_BRUSH); //��ˢ
	wndclass.lpszMenuName = NULL ;
	wndclass.lpszClassName = szAppName; //������
	//ע��
	if (!RegisterClass (&wndclass))
	{
		MessageBox (NULL, TEXT ("RegisterClass Fail!"),
				szAppName, MB_ICONERROR) ;
		return 0 ;
	}
	*/

	//��������
	HWND hwnd ;
	hwnd = CreateWindowEx(
			WS_EX_DLGMODALFRAME,
			//WS_EX_APPWINDOW,
			"#32770",
			//szAppName,
			TEXT("The Hello Program"),
			//WS_OVERLAPPEDWINDOW,
			WS_POPUP,
			0,
			0,
			400,
			300,
			NULL,
			NULL,
			NULL,
			NULL);

	sprintf(cBuffer,"%s","Hello \n world!\n�Ǿ����ڲ���.--------------------\n^_^\n");
	SetWindowLongPtr(hwnd,DWL_DLGPROC,(LPARAM)WndProc);

	ShowWindow (hwnd, iCmdShow) ;
	UpdateWindow (hwnd) ;

	//��Ϣѭ��
	MSG msg ;
	while (!stoped ) {
		if ( GetMessage(&msg,NULL,0,0)== 0 ) {
			break;
		}
		TranslateMessage (&msg) ; //ת����Ϣ
		DispatchMessage (&msg) ; //�ɷ���Ϣ
	}

	/*
	while (GetMessage (&msg, NULL, 0, 0) ) //����Ϣ������ȡ��Ϣ
	{
		TranslateMessage (&msg) ; //ת����Ϣ
		DispatchMessage (&msg) ; //�ɷ���Ϣ
	}
	*/
	return 0 ;
}
#endif
// vim: ts=4:sw=4:sts=4
