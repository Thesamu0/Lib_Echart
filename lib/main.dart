import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'alunos.dart';
import 'aprovados.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

Material cardDisplay(Widget chart) {
  return Material(
    color: Colors.white,
    elevation: 4.0,
    shadowColor: Color(0x802196F3),
    borderRadius: BorderRadius.circular(24.0),
    child: Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: chart,
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste"),
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OutraPage()),
                );
              },
              child: cardDisplay(BarChart.withSampleData())),
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OutraPage()),
                );
              },
              child: cardDisplay(PieChartDash.withSampleData())),
          InkWell(onTap: () {}, child: cardDisplay(BarProc.withSampleData())),
          InkWell(onTap: () {}, child: cardDisplay(LineChart.withSampleData())),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 340),
          StaggeredTile.extent(2, 170),
          StaggeredTile.extent(2, 170),
          StaggeredTile.extent(2, 170),
        ],
      ),
    );
  }
}

List<charts.Series<Alunos, String>> exemploDados1() {
  final dados = [
    new Alunos(500, 'Mar'),
    new Alunos(1200, 'Abr'),
    new Alunos(1600, 'Mai'),
    new Alunos(2300, 'Jun')
  ];

  return [
    new charts.Series<Alunos, String>(
      id: 'Alunos de Celular',
      data: dados,
      measureFn: (Alunos alu, _) =>
          alu.quantidade, //Definindo qual atributo vai ser medido
      domainFn: (Alunos alu, _) =>
          alu.mes, //Definindo qual atributo vai ser o domínio
    )
  ];
}

List<charts.Series<Alunos, String>> exemploDados2() {
  final dados = [
    new Alunos(600, '≤3'),
    new Alunos(1600, '>3 e ­­≤5'),
    new Alunos(1400, '>5 e ≤7'),
    new Alunos(2000, '>7')
  ];

  return [
    new charts.Series<Alunos, String>(
      id: 'Alunos',
      data: dados,
      domainFn: (Alunos alu, _) => alu.mes,
      measureFn: (Alunos alu, _) => alu.quantidade,
      labelAccessorFn: (Alunos alu, _) => '${alu.quantidade}',
    ),
  ];
}

List<charts.Series<Alunos, String>> exemploDados3() {
  final dados = [
    new Alunos(100, 'Adm.'),
    new Alunos(250, 'Acad.'),
    new Alunos(60, 'Ext.'),
    new Alunos(50, 'Inc.'),
  ];

  return [
    new charts.Series<Alunos, String>(
      id: 'Processos',
      data: dados,
      measureFn: (Alunos alu, _) =>
          alu.quantidade, //Definindo qual atributo vai ser medido
      domainFn: (Alunos alu, _) =>
          alu.mes, //Definindo qual atributo vai ser o domínio
    )
  ];
}

List<charts.Series<Aprovados, double>> exemploDados4() {
  final dados = [
    new Aprovados(2800, 2018.1),
    new Aprovados(1500, 2018.6),
    new Aprovados(3400, 2019.1),
    new Aprovados(2500, 2019.6),
  ];

  return [
    new charts.Series<Aprovados, double>(
      id: 'Processos',
      data: dados,
      measureFn: (Aprovados alu, _) =>
          alu.quantidade, //Definindo qual atributo vai ser medido
      domainFn: (Aprovados alu, _) =>
          alu.semestre, //Definindo qual atributo vai ser o domínio
    )
  ];
}

class LineChart extends StatelessWidget {
  final List<charts.Series> serieslist;
  final bool animation;

  LineChart(this.serieslist, {this.animation});

  factory LineChart.withSampleData() {
    return new LineChart(exemploDados4(), animation: false);
    /*Essa função serve para que o widget possa ser chamado e
    utilizado sem precisar do construtor*/
  }

  @override
  Widget build(BuildContext context) {
    final statickticks = <charts.TickSpec<double>>[
      new charts.TickSpec(2018.1, label: '2018.1'),
      new charts.TickSpec(2018.6, label: '2018.2'),
      new charts.TickSpec(2019.1, label: '2019.1'),
      new charts.TickSpec(2019.6, label: '2019.2'),
    ];

    return charts.LineChart(
      serieslist,
      animate: false,
      defaultInteractions: false,
      primaryMeasureAxis: new charts.NumericAxisSpec(
        tickProviderSpec:
            new charts.BasicNumericTickProviderSpec(desiredTickCount: 6),
      ),
      domainAxis: new charts.NumericAxisSpec(
          viewport: new charts.NumericExtents(2018, 2019.6),
          tickProviderSpec:
              new charts.StaticNumericTickProviderSpec(statickticks)),
      behaviors: [
        new charts.ChartTitle('Alunos aprovados por semestre',
            subTitle: 'Sem reprovação em nenhuma cadeira')
      ],
    );
  }
}

class BarChart extends StatelessWidget {
  final List<charts.Series> serieslist;
  final bool animation;

  BarChart(this.serieslist, {this.animation});

  factory BarChart.withSampleData() {
    return new BarChart(exemploDados1(), animation: false);
    /*Essa função serve para que o widget possa ser chamado e
    utilizado sem precisar do construtor*/
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      serieslist,
      animate: animation,
      defaultInteractions: false,
      behaviors: [
        new charts.ChartTitle(
          'Número de alunos pesquisados',
          subTitle: 'Ano: 2020',
          behaviorPosition: charts.BehaviorPosition.top,
          titleOutsideJustification: charts.OutsideJustification.start,
          titleStyleSpec: charts.TextStyleSpec(fontSize: 20),
        )
      ],
      primaryMeasureAxis: new charts.NumericAxisSpec(
        tickProviderSpec:
            new charts.BasicNumericTickProviderSpec(desiredTickCount: 8),
      ),
      /*Nesse return é onde as propriedades do gráfico podem ser
      modificadas, como colocar títulos, definir se terá animações
      ou não, dentre outras coisas*/
    );
  }
}

class BarProc extends StatelessWidget {
  @override
  final List<charts.Series> serieslist;
  final bool animate;

  BarProc(this.serieslist, {this.animate});

  factory BarProc.withSampleData() {
    return new BarProc(
      exemploDados3(),
      animate: false,
    );
  }

  Widget build(BuildContext context) {
    return charts.BarChart(
      serieslist,
      animate: animate,
      defaultInteractions: false,
      behaviors: [
        new charts.ChartTitle(
          'Número e tipo de processos em aberto',
          behaviorPosition: charts.BehaviorPosition.top,
          titleOutsideJustification: charts.OutsideJustification.start,
          titleStyleSpec: charts.TextStyleSpec(fontSize: 16),
        )
      ],
      primaryMeasureAxis: new charts.NumericAxisSpec(
        tickProviderSpec:
            new charts.BasicNumericTickProviderSpec(desiredTickCount: 8),
      ),
      /*Nesse return é onde as propriedades do gráfico podem ser
      modificadas, como colocar títulos, definir se terá animações
      ou não, dentre outras coisas*/
    );
  }
}

class PieChartDash extends StatelessWidget {
  final List<charts.Series> serieslist;
  final bool animate;

  PieChartDash(this.serieslist, {this.animate});

  factory PieChartDash.withSampleData() {
    return new PieChartDash(
      exemploDados2(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      serieslist,
      animate: animate,
      defaultInteractions: false,
      behaviors: [
        new charts.DatumLegend(
            position: charts.BehaviorPosition.end,
            outsideJustification: charts.OutsideJustification.endDrawArea),
        new charts.ChartTitle(
          'Alunos por nota média',
          behaviorPosition: charts.BehaviorPosition.top,
          titleOutsideJustification: charts.OutsideJustification.start,
          titleStyleSpec: charts.TextStyleSpec(fontSize: 16),
        )
      ],
    );
  }
}

class PieChartPage extends StatelessWidget {
  final List<charts.Series> serieslist;
  final bool animate;

  PieChartPage(this.serieslist, {this.animate});

  factory PieChartPage.withSampleData() {
    return new PieChartPage(
      exemploDados2(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      serieslist,
      animate: animate,
      defaultInteractions: false,
      defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
        new charts.ArcLabelDecorator(
          labelPadding: 0,
          labelPosition: charts.ArcLabelPosition.outside,
          showLeaderLines: false,
        )
      ]),
      behaviors: [
        new charts.ChartTitle(
          'Alunos por nota média',
          behaviorPosition: charts.BehaviorPosition.top,
          titleOutsideJustification: charts.OutsideJustification.startDrawArea,
          outerPadding: 10,
          titleStyleSpec: charts.TextStyleSpec(fontSize: 14),
        ),
        new charts.DatumLegend(
          position: charts.BehaviorPosition.end,
          outsideJustification: charts.OutsideJustification.endDrawArea,
        )
      ],
    );
  }
}

class OutraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gráfico de nota média')),
      body: Center(
        child: Container(
          width: 500,
          height: 250,
          child: PieChartPage.withSampleData(),
        ),
      ),
    );
  }
}
