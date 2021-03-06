import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:havemyback/models/mentorModel.dart';
import 'package:havemyback/models/organisationModel.dart';
import '../locator.dart';

import '../api.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Mentor> mentors;
  List<Organisation> organisations;
  List<Mentor> organisationMentors;
  Organisation organisation;

  Future<List<Mentor>> fetchMentors() async {
    var result = await _api.getDataCollection('mentors');
    mentors = result.documents
        .map((doc) => Mentor.fromMap(doc.data, doc.documentID))
        .toList();
    return mentors;
  }

  Future<List<Mentor>> fetchMentorsBySpecialisation(String specialisation) async {
    var result = await _api.getDataByEqualQuery('mentors', 'specialisation', specialisation);
    mentors = result.documents
        .map((doc) => Mentor.fromMap(doc.data, doc.documentID))
        .toList();
    return mentors;
  }

  Stream<QuerySnapshot> fetchMentorsAsStream() {
    return _api.streamDataCollection('mentors');
  }

  Future<Mentor> getMentorById(String id) async {
    var doc = await _api.getDocumentById('mentors',id);
    return  Mentor.fromMap(doc.data, doc.documentID) ;
  }


  Future removeMentor(String id) async{
    await _api.removeDocument('mentors', id) ;
    return ;
  }
  Future updateMentor(Mentor data,String id) async{
    await _api.updateDocument('mentors', data.toJson(), id) ;
    return ;
  }

  Future addMentor(Mentor data) async{
    var result  = await _api.addDocument('mentors' , data.toJson()) ;
    return ;

  }

  Future<List<Organisation>> fetchOrganisations() async {
    var result = await _api.getDataCollection('organisations');
    organisations = result.documents
        .map((doc) => Organisation.fromMap(doc.data, doc.documentID))
        .toList();
    return organisations;
  }

  Future<Organisation> fetchOrganisationById(String id) async {
    var result = await _api.getDocumentById('organisations',id);
    return Organisation.fromMap(result.data, result.documentID);
  }

  Future<List<Organisation>> fetchOrganisationsByCategory(String specialisation) async {
    var result = await _api.getDataByEqualQuery('organisations', 'category', specialisation);
    organisations = result.documents
        .map((doc) => Organisation.fromMap(doc.data, doc.documentID))
        .toList();
    return organisations;
  }


//  Future<List<Mentor>> fetchOrganisationMentors(String id) async {
//    var result = await _api.getDocumentById('organisations',id);
//    organisation =  Organisation.fromMap(result.data, result.documentID);
//    List<String> mentorIds = organisation.mentors;
//    for(var id in mentorIds){
//      Mentor mentor = await getMentorById(id);
//      print(mentor);
//      organisationMentors.add(mentor);
//    }
//    for ( var id in mentorIds){
//      Mentor mentor = await getMentorById(id);
//      print("mentor");
//      print(mentor);
//    }
//    print("mentors:");
//    print(organisationMentors);
//    return organisationMentors;
//  }

  Future<bool> determineIfMentor(String id) async{
    //check if mentor
    var result = await _api.getDataCollection('mentors');
    mentors = result.documents
        .map((doc) => Mentor.fromMap(doc.data, doc.documentID))
        .toList();
    for (var m in mentors){
      if(m.id==id){
        print('A mentor');
        return true;
      }
    }
    print('An org');
    return false; //org

  }
  /*   what i wanted to do istoo complex
  Future<List<List<String>>> getExperienceCollection(String id)async{
    await _api.addExperiencestoDocument('mentors',id);//add experiences
    var doc = await _api.getDocumentById('mentors',id);
    return Mentor.fromMap(doc.data, doc.documentID) ;
   
  }
  */

  Future updateOrganisation(Organisation data,String id) async{
    await _api.updateDocument('organisations', data.toJson(), id) ;
    return ;
  }

}