import 'package:flutter/material.dart';

class Search1 extends StatefulWidget {
  final List<String> list = [
    "Fiscal",
    "Fiscal >> Codes",
    "Fiscal >> Lois de finances",
    "Fiscal >> Lois",
    "Fiscal >> Décrets",
    "Fiscal >> Arrêtés",
    "Fiscal >> Notes communes",
    "Fiscal >> Prise de positions",
    "Fiscal >> Notes internes",
    "Fiscal >> Jurisprudence",
    "Fiscal >> Système comptable",
    "Fiscal >> Conventions de non double imposition",
    "Fiscal >> Circulaires",
    "Fiscal >> Douane",
    "Social",
    "Social >> Codes",
    "Social >> Lois",
    "Social >> Décrets",
    "Social >> Arrêtés",
    "Social >> Circulaires",
    "Social >> Notes internes",
    "Social >> Jurisprudence",
    "Social >> Notes communes fiscales",
    "Social >> Conventions cadre et sectorielles",
    "Social >> Conventions bilatérales",
    "Social >> Convention internationale",
    "Investissement",
    "Investissement >> Codes",
    "Investissement >> Décrets",
    "Investissement >> Arrêtés",
    "Investissement >> Notes communes",
    "Investissement >> Notes internes",
    "Investissement >> Circulaires",
    "Investissement >> Cahiers des charges",
    "Investissement >> Douane",
    "Banque - Finances - Assurances",
    "Banque - Finances - Assurances >> Codes",
    "Banque - Finances - Assurances >> Lois",
    "Banque - Finances - Assurances >> Décrets",
    "Banque - Finances - Assurances >> Arrêtés",
    "Banque - Finances - Assurances >> Notes communes",
    "Banque - Finances - Assurances >> Jurisprudence",
    "Banque - Finances - Assurances >> Circulaires",
    "Banque - Finances - Assurances >> Notes bancaires",
    "Banque - Finances - Assurances >> Décision",
    "Banque - Finances - Assurances >> Conventions cadre et sectorielles",
    "Banque - Finances - Assurances >> Marché Financier",
    "Banque - Finances - Assurances >> Microfinance",
    "BIBUS",
    "BIBUS >> Constitution",
    "BIBUS >> Codes",
    "Collectivités locales",
    "Collectivités locales >> Codes",
    "Collectivités locales >> Lois",
    "Collectivités locales >> Décrets",
    "Collectivités locales >> Arrêtés",
    "Collectivités locales >> Circulaires",
    "Collectivités locales >> Notes communes",
    "Collectivités locales >> Notes internes",
    "Collectivités locales >> Jurisprudence",
    "Collectivités locales >> Prise de positions",
    "Collectivités locales >> Cahiers des charges",
    "Veille Juridique",









  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Search1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search(widget.list));
            },
            icon: Icon(Icons.search),
          )
        ],
        centerTitle: true,
        title: Text('Recherchez par mot clé'),
      ),
      body: ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            widget.list[index],
          ),
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = ["Fiscal", "Social"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
      // In the false case
          (element) => element.contains(query),
    ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: (){
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
