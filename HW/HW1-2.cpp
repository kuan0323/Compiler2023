#include <iostream>
#include <string>
#include <vector>
#include <regex>

using namespace std;

const regex NUM("([1-9][0-9]*)|0");
const regex PLUS("\\+");
const regex MINUS("\\-");
const regex MUL("\\*");
const regex DIV("\\/");
const regex LPR("\\(");
const regex RPR("\\)");

vector<string> results;

bool match(string &inputs, const regex &pattern, string patternName)
{
    smatch matches;
    // cout << "match() inputs: " << inputs << endl;
    if (regex_search(inputs, matches, pattern))
    {
        if (matches.position() == 0)
        {
            results.push_back(patternName);
            // cout << "match() pick: " << matches.str() << endl;
            // cout << "match() pick position: " << matches.position() << endl;
            inputs = matches.suffix();
            // cout << "match() remain inputs: " << inputs << endl;
            return true;
        }
        else
        {
            return false;
        }
    }
    return false;
}
bool matchNUM(string &inputs, const regex &pattern, string patternName)
{
    smatch matches;
    // cout << "match() inputs: " << inputs << endl;
    if (regex_search(inputs, matches, pattern))
    {
        if (matches.position() == 0)
        {
            results.push_back(patternName + " " + matches.str(0));
            // cout << "match() pick: " << matches.str() << endl;
            // cout << "match() pick position: " << matches.position() << endl;
            inputs = matches.suffix();
            // cout << "match() remain inputs: " << inputs << endl;
            return true;
        }
        else
        {
            return false;
        }
    }
    return false;
}

int main()
{
    string inputs;
    string input;

    while (cin >> input)
    {
        inputs = inputs + input;
    }
    // cout << inputs << endl;
    while (!inputs.empty())
    {
        // cout << "test" << endl;
        if (matchNUM(inputs, NUM, "NUM"))
        {
            continue;
        }
        else if (match(inputs, PLUS, "PLUS"))
        {
            continue;
        }
        else if (match(inputs, MINUS, "MINUS"))
        {
            continue;
        }
        else if (match(inputs, MUL, "MUL"))
        {
            continue;
        }
        else if (match(inputs, DIV, "DIV"))
        {
            continue;
        }
        else if (match(inputs, LPR, "LPR"))
        {
            continue;
        }
        else if (match(inputs, RPR, "RPR"))
        {
            continue;
        }
        else
        {
            break;
        }
    }
    for (int i = 0; i < results.size(); ++i)
    {
        cout << results[i] << endl;
    }
}