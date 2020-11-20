#include <nuspell/dictionary.hxx>
#include <nuspell/finder.hxx>

using namespace std;

int main() {
	auto dict_list = vector<pair<string, string>>();
	nuspell::search_default_dirs_for_dicts(dict_list);
	auto dict_name_and_path = nuspell::find_dictionary(dict_list, "en_US");
	if (dict_name_and_path == end(dict_list))
		return 1;
	auto& dict_path = dict_name_and_path->second;
	auto dict = nuspell::Dictionary::load_from_path(dict_path);
}
