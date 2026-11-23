// Questão 2: Interface para gerenciamento de empréstimos
abstract interface class Emprestavel {
  bool get disponivel;
  bool emprestar();
  void devolver();
}

// Questão 1: Classe abstrata base
abstract class Livro {
  final String codigo;
  String _titulo;
  String? autor;

  Livro({
    required this.codigo,
    required String titulo,
    this.autor,
  }) : _titulo = titulo.trim();

  String get titulo => _titulo;

  set titulo(String novoTitulo) {
    final tituloLimpo = novoTitulo.trim();
    if (tituloLimpo.isNotEmpty) {
      _titulo = tituloLimpo;
    }
  }

  String get autorExibicao =>
      (autor == null || autor!.trim().isEmpty) ? 'Autor desconhecido' : autor!.trim();

  String descricao();
}

// Questão 1: Extensão em Dart para gerar a referência bibliográfica
extension LivroReferenciaExtension on Livro {
  String gerarReferencia() {
    return '$titulo - $autorExibicao';
  }
}

// Questão 1 e 2: Livro Físico (herda de Livro e implementa Emprestavel)
class LivroFisico extends Livro implements Emprestavel {
  final int numeroPaginas;
  bool _disponivel = true;

  LivroFisico({
    required super.codigo,
    required super.titulo,
    super.autor,
    required this.numeroPaginas,
  });

  @override
  bool get disponivel => _disponivel;

  @override
  bool emprestar() {
    if (!_disponivel) {
      return false;
    }
    _disponivel = false;
    return true;
  }

  @override
  void devolver() {
    _disponivel = true;
  }

  @override
  String descricao() {
    final status = _disponivel ? 'Disponível' : 'Emprestado';
    return '[Físico] Cód: $codigo | Título: "$titulo" | Autor: $autorExibicao | Páginas: $numeroPaginas | Status: $status';
  }
}

// Questão 1: Livro Digital (apenas herda de Livro, não pode ser emprestado)
class LivroDigital extends Livro {
  final double tamanhoMb;

  LivroDigital({
    required super.codigo,
    required super.titulo,
    super.autor,
    required this.tamanhoMb,
  });

  @override
  String descricao() {
    return '[Digital] Cód: $codigo | Título: "$titulo" | Autor: $autorExibicao | Tamanho: ${tamanhoMb.toStringAsFixed(1)} MB';
  }
}

// Questão 2: Execução e demonstração no main
void main() {
  final List<Livro> catalogo = [
    LivroFisico(
      codigo: 'FIS-001',
      titulo: 'Código Limpo',
      autor: 'Robert C. Martin',
      numeroPaginas: 425,
    ),
    LivroDigital(
      codigo: 'DIG-002',
      titulo: 'Arquitetura Limpa',
      autor: 'Robert C. Martin',
      tamanhoMb: 14.8,
    ),
    LivroFisico(
      codigo: 'FIS-003',
      titulo: 'Contos Populares Brasileiros',
      numeroPaginas: 180,
    ),
  ];

  print('=== CATÁLOGO INICIAL (DESCRIÇÕES E REFERÊNCIAS) ===');
  for (final livro in catalogo) {
    print(livro.descricao());
    print('Referência: ${livro.gerarReferencia()}\n');
  }

  print('=== TESTE DE ENCAPSULAMENTO DO TÍTULO ===');
  final livroTesteTitulo = catalogo.first;
  print('Título original: "${livroTesteTitulo.titulo}"');

  livroTesteTitulo.titulo = '   Código Limpo: Edição Revisada   ';
  print('Após entrada válida com espaços: "${livroTesteTitulo.titulo}"');

  livroTesteTitulo.titulo = '     ';
  print('Após entrada em branco: "${livroTesteTitulo.titulo}"\n');

  print('=== TESTE DE EMPRÉSTIMO E DEVOLUÇÃO ===');
  final livroFisico = catalogo[0] as LivroFisico;
  print('Disponibilidade inicial (${livroFisico.titulo}): ${livroFisico.disponivel}');

  final primeiraTentativa = livroFisico.emprestar();
  print('1ª tentativa de empréstimo aceita? $primeiraTentativa | Disponível agora: ${livroFisico.disponivel}');

  final segundaTentativa = livroFisico.emprestar();
  print('2ª tentativa de empréstimo aceita? $segundaTentativa | Disponível agora: ${livroFisico.disponivel}');

  livroFisico.devolver();
  print('Após devolução -> Disponível agora: ${livroFisico.disponivel}');

  livroFisico.devolver();
  print('Após devolver livro já disponível -> Disponível agora: ${livroFisico.disponivel}');
}