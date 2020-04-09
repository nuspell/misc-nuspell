Name:      nuspell
Summary:   A spell checker library and command-line tool
Version:   3.1.0
Release:   0%{?dist}
Source:    https://github.com/nuspell/nuspell/archive/v%{version}.tar.gz
URL:       https://nuspell.github.io/
License:   LGPLv3+
BuildRequires: cmake make gcc-c++ libicu-devel boost-devel rubygem-ronn
Requires:  hunspell-en-US

%description
Nuspell is a free and open source spell checker that is written in modern C++.
It is designed for languages with rich morphology and complex word compounding.

Main features are:
 - Full unicode support backed by ICU
 - Backward compatibility with Hunspell dictionary file format
 - Twofold affix stripping (for agglutinative languages, like Azeri,
   Basque, Estonian, Finnish, Hungarian, Turkish, etc.)
 - Support complex compounds (for example, Hungarian, Germand and Dutch)
 - Support language specific features (for example, special casing of
   Azeri and Turkish dotted i, or German sharp s)
 - Handle conditional affixes, circumfixes, fogemorphemes, forbidden
   words, pseudoroots and homonyms.

%package devel
Requires: nuspell = %{version}-%{release}, pkgconfig
Summary: Files for developing with Nuspell

%description devel
Includes and definitions for developing with Nuspell

%prep
%setup -q

%build
%cmake -DBUILD_SHARED_LIBS=ON -DBUILD_TESTING=OFF .
%make_build


%install
%make_install

%files
%doc README.md CHANGELOG.md AUTHORS
%license COPYING.LESSER
%{_libdir}/*.so.*
%{_bindir}/nuspell
%{_mandir}/man1/nuspell.1.gz

%files devel
%{_includedir}/%{name}
%{_libdir}/*.so
%{_libdir}/pkgconfig/nuspell.pc
%{_libdir}/cmake/%{name}

%changelog
* Thu Apr 09 2020 Pander <pander@users.sourceforge.net> - 3.1.0-0
- Bumped version

* Thu Mar 05 2020 Pander <pander@users.sourceforge.net> - 3.0.0-0
- Initial contribution

