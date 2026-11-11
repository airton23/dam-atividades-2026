enum Classificacao { semAvaliacoes, baixa, regular, alta }

void main() {
  const notaMinima = 1;
  const notaMaxima = 5;
  const notaPositiva = 4;

  // Todas as notas recebidas representam números inteiros.
  // Algumas estão fora do intervalo permitido.
  final notasRecebidas = <String, List<String>>{
    'Agenda UFAPE': ['5', '4', '5', '0', '3', '6'],
    'Biblioteca Digital': ['3', '2', '4', '1'],
    'Mapa do Campus': [],
    'Restaurante Universitário': ['5', '5', '4', '4', '5'],
    'Transporte Universitário': ['0', '6', '-1'],
  };

  final categoriasPorApp = <String, String>{
    'Agenda UFAPE': 'Organização',
    'Biblioteca Digital': 'Serviços',
    'Mapa do Campus': 'Localização',
    'Restaurante Universitário': 'Serviços',
    'Transporte Universitário': 'Serviços',
  };

  final contatosPorApp = <String, String?>{
    'Agenda UFAPE': 'agenda@exemplo.com',
    'Biblioteca Digital': null,
    'Mapa do Campus': 'mapa@exemplo.com',
    'Restaurante Universitário': 'ru@exemplo.com',
    // Transporte Universitário não possui chave neste mapa.
  };

  final notasValidasPorApp = <String, List<int>>{};
  final descartadasPorApp = <String, int>{};
  final categoriasUnicas = <String>{};

  // QUESTÃO 1 — PREPARAÇÃO DOS DADOS
  // TODO: percorra todos os aplicativos e converta as notas para int.
  // Guarde notas de 1 a 5 em notasValidasPorApp, conte as demais em
  // descartadasPorApp e reúna as categorias em categoriasUnicas.
  // Inclua no resultado também os aplicativos sem notas válidas.

  for (final app in notasRecebidas.keys) {
    final validas = <int>[];
    var descartadas = 0;

    for (final notaStr in notasRecebidas[app]!) {
      final nota = int.parse(notaStr);
      if (nota >= notaMinima && nota <= notaMaxima) {
        validas.add(nota);
      } else {
        descartadas++;
      }
    }

    notasValidasPorApp[app] = validas;
    descartadasPorApp[app] = descartadas;

    if (categoriasPorApp.containsKey(app)) {
      categoriasUnicas.add(categoriasPorApp[app]!);
    }
  }

  // QUESTÃO 2 — RELATÓRIO
  print('RELATÓRIO DE AVALIAÇÕES');
  print('======================');

  for (final app in notasRecebidas.keys) {
    final categoria = categoriasPorApp[app] ?? 'Não informada';
    final contato = contatosPorApp[app] ?? 'Não informado';
    final validas = notasValidasPorApp[app] ?? [];
    final descartadas = descartadasPorApp[app] ?? 0;

    String mediaTexto;
    String percentualPositivasTexto;
    Classificacao classificacao;

    if (validas.isEmpty) {
      mediaTexto = 'Não calculado';
      percentualPositivasTexto = 'Não calculado';
      classificacao = Classificacao.semAvaliacoes;
    } else {
      final soma = validas.reduce((a, b) => a + b);
      final media = soma / validas.length;
      final positivas = validas.where((n) => n >= notaPositiva).length;
      final percentual = (positivas / validas.length) * 100;

      mediaTexto = media.toStringAsFixed(2);
      percentualPositivasTexto = '${percentual.toStringAsFixed(1)}%';

      if (media < 3) {
        classificacao = Classificacao.baixa;
      } else if (media < 4) {
        classificacao = Classificacao.regular;
      } else {
        classificacao = Classificacao.alta;
      }
    }

    // TODO: para cada aplicativo, mostre categoria, contato, quantidade de
    // notas válidas e descartadas, média, porcentagem de notas positivas
    // (maiores ou iguais a notaPositiva) e classificação.
    // Use o enum Classificacao e switch para o texto da classificação.
    // Trate a ausência de contato e evite divisão por zero.

    String classificacaoTexto;
    switch (classificacao) {
      case Classificacao.semAvaliacoes:
        classificacaoTexto = 'Sem avaliações';
        break;
      case Classificacao.baixa:
        classificacaoTexto = 'Baixa';
        break;
      case Classificacao.regular:
        classificacaoTexto = 'Regular';
        break;
      case Classificacao.alta:
        classificacaoTexto = 'Alta';
        break;
    }

    print('Aplicativo: $app');
    print('  Categoria: $categoria');
    print('  Contato: $contato');
    print('  Notas válidas: ${validas.length}');
    print('  Notas descartadas: $descartadas');
    print('  Média: $mediaTexto');
    print('  Notas positivas: $percentualPositivasTexto');
    print('  Classificação: $classificacaoTexto');
    print('----------------------------------------');
  }

  print('\nCATEGORIAS ENCONTRADAS');
  // TODO: exiba as categorias sem repetições.
  for (final categoria in categoriasUnicas) {
    print('- $categoria');
  }
}
