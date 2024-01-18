#include <iostream>
#include <string>
#include <vector>
#include <regex>

using namespace std;

const regex ID("[A-Za-z_][A-Za-z0-9_]*");
const regex STRLIT("\"[^\"]*\"");
const regex LBR("\\(");
const regex PBR("\\)");
const regex DOT("\\.");

// string input;
vector<string> resultVector;

bool match(string &input, const regex &pattern, string &token, string patternName)
{
    // if (regex_search(input, pattern))
    // {
    smatch match;
    if (regex_search(input, match, pattern))
    {
        if (match.position() == 0)
        {
            token = match.str();
            input = match.suffix();
            resultVector.push_back(patternName + " " + token);
            // cout << "match test: " << patternName << " " << token << endl;
            return true;
        }
    }
    // }
    return false;
}

bool stmts(string &input);
bool stmt(string &input);
bool primary(string &input);

bool primary_tail(string &input)
{
    string token;
    // cout << "test" << endl;
    if (match(input, DOT, token, "DOT"))
    {
        return match(input, ID, token, "ID") && primary_tail(input);
    }
    else if (match(input, LBR, token, "LBR"))
    {
        stmt(input);
        if (match(input, PBR, token, "RBR"))
        {
            return primary_tail(input);
        }
        else
        {
            resultVector.clear();
            resultVector.push_back("invalid input");
            // input += 'i';
            // return primary_tail(input); //只有左括號的情況是invalid，但目前判斷有左括號不一定要有右括號
        }
    }
    return true;
}

bool primary_tail(string &input);

bool primary(string &input)
{
    string token;
    if (match(input, ID, token, "ID"))
    {
        return primary_tail(input);
    }
    return false;
}

bool stmt(string &input)
{
    string token;
    smatch match;
    if (regex_search(input, match, STRLIT))
    {
        if (match.position() == 0)
        {
            token = match.str();
            input = match.suffix();
            resultVector.push_back("STRLIT " + token);
            // cout << "STRLIT " << token << endl;
            return true;
        }
    }
    // cout << "Stmt: " << input << endl;
    if (primary(input))
    {
        // cout << "test" << endl;
        return true;
    }
    return false;
}

bool stmts(string &input)
{
    // cout << "Stmts: " << input << endl;
    return stmt(input) && stmts(input);
}

int main()
{
    string input;
    vector<string> inputs;
    string result;
    while (getline(cin, input) && !input.empty())
    {
        inputs.push_back(input);
    }
    for (vector<int>::size_type i = 0; i < inputs.size(); ++i)
    {
        input = inputs[i];
        resultVector.clear();
        if (!stmts(input) && input.empty())
        {
            for (vector<int>::size_type j = 0; j < resultVector.size(); ++j)
            {
                // cout << resultVector[j] << endl;
                result = result + resultVector[j] + "\n";
            }
            // resultVector.clear();
            // cout << endl;
        }
        else
        {
            // cout << "invalid input" << endl;
            result = result + "invalid input\n";
        }
    }
    result.erase(result.length() - 1);
    cout << result << endl;

    return 0;
}
