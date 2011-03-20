// wspawn
// g++ -o ../plugin/vjde/wspawn wspawn.cpp -mwindows

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <string>
#include <windows.h>

using namespace std;

void exit_friendly(void)
{
    puts("�벻Ҫ��������wSpawn.");
    exit(0);
}

int main( int argc, char *argv[] )
{
    HANDLE  hWrite = NULL;
    DWORD   dwWrited;
    int     i = 0, ret = 0, len = 0;
    char    psBuffer[256];
    FILE*   child_output;
    string  command_line = "";

    // ��������У�����ڹܵ����������ת��ΪHANDLE����
    if (argc < 2)
        exit_friendly();
    if (!stricmp(argv[1], "-h"))
    {
        if (argc < 4)
            exit_friendly();
        hWrite = (HANDLE)atoi(argv[2]);
        i = 3;
    }
    else
        i = 1;

    // ��ȡҪִ�е�����
    for (; i < argc; i++)
    {
        command_line += argv[i];
        command_line += " ";
    }

    // ʹ��_popen�����ӽ��̲��ض������׼������ļ�ָ����
    if( (child_output = _popen( command_line.c_str(), "rt" )) == NULL )
        exit( 1 );

    while( !feof( child_output ) )
    {
        if( fgets( psBuffer, 255, child_output ) != NULL )
        {
            if (hWrite)
            {
                // ���ӽ��̵ı�׼���д��ܵ����ṩ���Լ��ĸ�����
                // ��ʽ����д���ݿ鳤�ȣ�0��ʾ����������д���ݿ�����
                len = strlen(psBuffer);
                WriteFile(hWrite, &len, sizeof(int), &dwWrited, NULL);
                WriteFile(hWrite, psBuffer, len, &dwWrited, NULL);
            }
            else
                // ��������δ�ṩ�ܵ��������ֱ�Ӵ�ӡ���
                printf(psBuffer);
        }
    }

    // д"0"��ʾ�������ݶ���д��
    len = 0;
    if (hWrite)
        WriteFile(hWrite, &len, sizeof(int), &dwWrited, NULL);

    return _pclose( child_output );
}
