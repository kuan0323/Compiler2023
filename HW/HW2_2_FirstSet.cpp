#include <iostream>
#include <map>
#include <set>
#include <vector>
#include <algorithm>

using namespace std;

int main()
{
    map<char, vector<string> > grammar; // save nonterminal's rule
    map<char, set<char> > firstSets;    // save nonterminal's first set

    char nonterminal;
    int line_count = 0;
    while (cin >> nonterminal)
    {
        string ruleStr;
        // identify if input is "END_OF_GRAMMAR"
        // save each rule after nonterminal
        if (nonterminal == 'E')
        {
            if (getline(cin, ruleStr))
            {
                ruleStr.erase(remove_if(ruleStr.begin(), ruleStr.end(), ::isspace), ruleStr.end());
                if (ruleStr == "ND_OF_GRAMMAR")
                {
                    break;
                }
            }
        }
        else
        {
            getline(cin, ruleStr);
            ruleStr.erase(remove_if(ruleStr.begin(), ruleStr.end(), ::isspace), ruleStr.end());
            //saperate the rule with'|' and save them in vector alternatives
        }
        vector<string> alternatives;
        size_t start = 0;
        size_t pos = ruleStr.find('|');
        while (pos != string::npos)
        {
            alternatives.push_back(ruleStr.substr(start, pos - start));
            start = pos + 1;
            pos = ruleStr.find('|', start);
        }
        alternatives.push_back(ruleStr.substr(start));

        // try to print every string in each rule which is just separate
        // for (int i = 0; i < alternatives.size(); ++i)
        // {
        //     cout << alternatives[i] << endl;
        // }
        // cout << "a! " << nonterminal << " " << ruleStr << endl;

        grammar[nonterminal] = alternatives;
        line_count = line_count + 1;
        // alternatives.clear();
    }
    // cout << "==================================" << endl;
    bool tag = true; // 記錄什麼時候沒有任何 Nonterminal 後面的 rule 還沒丟進 first set
    vector<char> processed;
    while (processed.size() < line_count)
    {
        tag = false;
        for (map<char, vector<string> >::iterator it = grammar.begin(); it != grammar.end(); ++it)
        {
            char Nonterminal = it->first;
            vector<string> Alternatives = it->second;
            if (find(processed.begin(), processed.end(), Nonterminal) == processed.end() &&
                all_of(Alternatives.begin(), Alternatives.end(), [](const string &alt) {
                    return (alt.size() == 1 && alt[0] == ';') || (islower(alt[0]));
                }))
            {
                processed.push_back(Nonterminal);
                // cout << "first processed: " << Nonterminal << endl;
                for (vector<string>::iterator itt = Alternatives.begin(); itt != Alternatives.end(); ++itt)
                {
                    size_t i = 0;
                    string alternative = *itt;
                    // cout << "alt: " << alternative << endl;
                    while (i < alternative.size())
                    {

                        if (islower(alternative[i]))
                        {
                            // 如果是Terminal，直接加入First Set
                            // cout << "tag1: " << alternative[i] << " i: " << i << endl;
                            firstSets[Nonterminal].insert(alternative[i]);
                            break;
                            // ++i;
                        }
                        else if (!isupper(alternative[i]))
                        {
                            // last ; can add in first set
                            // cout << "tag2: " << alternative[i] << " i: " << i << endl;
                            firstSets[Nonterminal].insert(alternative[i]);
                        }

                        i = i + 1;
                    }
                }
            }
        }

        for (map<char, vector<string> >::iterator it = grammar.begin(); it != grammar.end(); ++it)
        {
            char Nonterminal = it->first;
            vector<string> Alternatives = it->second;
            // cout << "second sec: " << Nonterminal << endl;
            if (find(processed.begin(), processed.end(), Nonterminal) == processed.end() &&
                all_of(Alternatives.begin(), Alternatives.end(), [Nonterminal](const string &alt) {
                    return all_of(alt.begin(), alt.end(), [Nonterminal](char c) {
                        return islower(c) || c == ';' || c == Nonterminal;
                    });
                }))
            {
                processed.push_back(Nonterminal);
                // cout << "processed: " << Nonterminal << endl;
                for (vector<string>::iterator itt = Alternatives.begin(); itt != Alternatives.end(); ++itt)
                {
                    size_t i = 0;
                    string alternative = *itt;
                    // cout << "alt: " << alternative << endl;
                    while (i < alternative.size())
                    {

                        if (islower(alternative[i]))
                        {
                            // 如果是Terminal，直接加入First Set
                            // cout << "tag1: " << alternative[i] << " i: " << i << endl;
                            firstSets[Nonterminal].insert(alternative[i]);
                            break;
                            // ++i;
                        }
                        else if (!isupper(alternative[i]) && i == alternative.size() - 1)
                        {
                            // last ; can add in first set
                            // cout << "tag2: " << alternative[i] << " i: " << i << endl;
                            firstSets[Nonterminal].insert(alternative[i]);
                        }
                        else if (alternative[i] == Nonterminal)
                        {
                            // 避免遞迴，跳過
                            // cout << "tag3: " << alternative[i] << " i: " << i << endl;
                            // continue;
                        }

                        i = i + 1;
                    }
                }
            }
        }
        // while
        for (map<char, vector<string> >::iterator it = grammar.begin(); it != grammar.end(); ++it)
        {
            char Nonterminal = it->first;
            vector<string> Alternatives = it->second;
            tag = false;
            // cout << "wwiiiiiiiii: " << Nonterminal << endl;
            // if (all_of(Alternatives.begin(), Alternatives.end(), [](const string &alt) {
            //         return all_of(alt.begin(), alt.end(), [](char c) {
            //             return islower(c) || c == ';';
            //         });
            //     }))
            // if (find(processed.begin(), processed.end(), Nonterminal) == processed.end())
            if (find(processed.begin(), processed.end(), Nonterminal) == processed.end() &&
                all_of(Alternatives.begin(), Alternatives.end(), [processed](const string &alt) {
                    return all_of(alt.begin(), alt.end(), [processed](char c) {
                        return islower(c) || c == ';' || c == '$' || find(processed.begin(), processed.end(), c) != processed.end();
                    });
                }))
            {
                // cout << "wweeeeee: " << Nonterminal << endl;
                processed.push_back(Nonterminal);
                // cout << "processed: " << Nonterminal << endl;
                // cout << "process size: " << processed.size() << endl;
                tag = true;
                for (vector<string>::iterator itt = Alternatives.begin(); itt != Alternatives.end(); ++itt)
                {

                    size_t i = 0;
                    string alternative = *itt;
                    // cout << "alt: " << alternative << endl;
                    while (i < alternative.size())
                    {

                        if (islower(alternative[i]))
                        {
                            // 如果是Terminal，直接加入First Set
                            // cout << "tag1: " << alternative[i] << " i: " << i << endl;
                            firstSets[Nonterminal].insert(alternative[i]);
                            break;
                            // ++i;
                        }
                        else if (!isupper(alternative[i]) && i == alternative.size() - 1)
                        {
                            // last ; can add in first set
                            // cout << "tag2: " << alternative[i] << " i: " << i << endl;
                            firstSets[Nonterminal].insert(alternative[i]);
                        }
                        else if (alternative[i] == Nonterminal)
                        {
                            // 避免遞迴，跳過
                            // cout << "tag3: " << alternative[i] << " i: " << i << endl;
                            // continue;
                        }
                        else if (isupper(alternative[i]))
                        {
                            // 如果是Nonterminal，加入其First Set
                            // cout << "tag4: " << alternative[i] << " i: " << i << endl;
                            // if ()
                            // firstSets[Nonterminal].insert(firstSets[alternative[i]].begin(), firstSets[alternative[i]].end());
                            // auto alternativeSetBegin = firstSets[alternative[i]].begin();
                            // auto alternativeSetEnd = firstSets[alternative[i]].end();

                            if (find(firstSets[alternative[i]].begin(), firstSets[alternative[i]].end(), ';') != firstSets[alternative[i]].end() &&
                                i + 1 != alternative.size())
                            {
                                // 如果firstSets[alternative[i]]中包含分号，且alternative[i+1]是终结符
                                for (const auto &terminal : firstSets[alternative[i]])
                                {
                                    if (terminal != ';')
                                    {
                                        // cout << "insert " << terminal << endl;
                                        firstSets[Nonterminal].insert(terminal);
                                    }
                                }
                            }
                            else
                            {
                                // 否则，加入其First Set
                                // cout << "insert the nonterminal " << alternative[i] << endl;
                                for (const auto &terminal : firstSets[alternative[i]])
                                {
                                    // cout << "insert " << terminal << endl;
                                    firstSets[Nonterminal].insert(terminal);
                                }
                                // firstSets[nonterminal].insert(firstSets[alternative[i]].begin(), firstSets[alternative[i]].end());
                            }
                        }
                        i = i + 1;
                    }
                }
            }
        }
    }
    // cout << "processed size: " << processed.size() << endl;

    // 輸出結果
    for (map<char, set<char> >::iterator itt = firstSets.begin(); itt != firstSets.end(); ++itt)
    {
        cout << itt->first << " ";
        // char nonterminal = itt->first;
        const set<char> &firstSet = itt->second;

        // 輸出Nonterminal和對應的First Set
        // cout << "Non: " << nonterminal << " " << endl;
        for (set<char>::iterator terminal = firstSet.begin(); terminal != firstSet.end(); ++terminal)
        {
            char c = *terminal;
            cout << c;
        }
        cout << endl;
    }
    cout << "END_OF_FIRST" << endl;

    return 0;
}