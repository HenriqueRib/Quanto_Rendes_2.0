import 'package:mobx/mobx.dart';
part 'utils.g.dart';

class Utils = UtilsBase with _$Utils;

abstract class UtilsBase with Store {
  @observable
  int indexPage = 0;

  @action
  setIndexPage(int i) {
    indexPage = i;
  }

  @observable
  int indexPageLicitacao = 0;

  @action
  setIndexPageLicitacao(int i) {
    indexPageLicitacao = i;
  }

  @observable
  bool loadingBtn = false;

  @action
  setLoadingBtn(bool v) {
    loadingBtn = v;
  }

  @observable
  bool loading = false;

  @action
  setLoading(bool v) {
    loading = v;
  }

  @observable
  int indexPageLogin = 0;

  @action
  setIndexPageLogin(int v) {
    indexPageLogin = v;
  }

  //validador form
  @observable
  String messageEmailValida = '';

  @action
  setMessageEmailValida(v) {
    messageEmailValida = v;
  }

  @observable
  bool seePassword = false;

  @action
  setSeePassword(bool v) {
    seePassword = v;
  }

  @observable
  bool formLogin = true;

  @action
  setformLogin(bool v) {
    formLogin = v;
  }

  // Page Pesquisa
  @observable
  bool pesquisaDetalhes = false;

  @action
  setpesquisaDetalhes(bool v) {
    pesquisaDetalhes = v;
  }

//Page Licitação.mensagem
  @observable
  List? mensagem;

  @action
  setMensagem() {
    mensagem = [
      {
        'id': '1',
        'data': '04/05/2020 09:24',
        'remetente': 'PREGOEIRO',
        'messagem':
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.',
      },
      {
        'id': '2',
        'data': '05/05/2020 13:27',
        'remetente': 'Usuario',
        'messagem':
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.',
      },
      {
        'id': '3',
        'data': '05/05/2020 14:24',
        'remetente': 'FORNECEDOR',
        'messagem':
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.',
      },
      {
        'id': '4',
        'data': '05/05/2020 14:27',
        'remetente': 'FORNECEDOR',
        'messagem':
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.',
      }
    ];
  }
}
